#Lütfen MySQL şifrelerini sıfırlamak istediğinizi onaylayın
CONFIRM="n"
echo -n "Please confirm MySQL password reset. Continue? (y/N): "
read -n 1 CONFIRM_INPUT
if [ -n "$CONFIRM_INPUT" ]; then
CONFIRM=$CONFIRM_INPUT
fi

echo

# MySQL şifresini sıfırlayıp sıfırlamadığımızı kontrol edin

if [[ "${CONFIRM}" =~ ^[Yy]$ ]]; then

# Şu anda çalışan mysql süresini sonlandır
echo 'mysql kapatılıyor...'
service mysqld stop
killall -vw mysqld

# grant tables olmadan mysql başlat
mysqld_safe --skip-grant-tables >res 2>&1 &

echo 'Parola değiştiriliyor... bekle'

# Yeni mysql işlemi başlatılırken 5 sn bekleyin (bağlantı hatası alırsanız bunu arttırmanız gerekebilir.)
sleep 5

rpm -qa | grep -qw pwgen &> /dev/null
if [ $? -eq 0 ]; then
echo "Pwgen paketi yüklü!"
else
echo "Pwgen paketi yüklü değil!"
yum install pwgen -y
echo "Pwgen paketi yüklendi!"
fi

# Parola oluşturuluyor
DB_ROOT_PASS_LEN=`shuf -i 20-30 -n 1`
DB_ROOT_PASS=`pwgen -scn $DB_ROOT_PASS_LEN 1`
DB_ROOT_USER='root'

# Root kullanıcısını yeni şifreyle güncelleniyor!
mysql mysql -e "UPDATE user SET Password=PASSWORD('$DB_ROOT_PASS') WHERE User='$DB_ROOT_USER';FLUSH PRIVILEGES;"

echo 'Değişiyor...'

# Kill the insecure mysql process
killall -v mysqld

# Starting mysql again
service mysqld restart

echo
echo "Şifre sıfırlama işlemi tamamlandı"
echo
echo "MySQL root password: $DB_ROOT_PASS"
echo
echo "Bu şifreyi güvenli bir şekilde saklamayı unutmayın!"
else
echo "Şifre sıfırlama iptal edildi"
fi

echo
