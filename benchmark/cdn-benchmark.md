#https://www.npmjs.com/package/cdn-bench

cdn-bench, özellikle dosya dağıtım ağları arasındaki farkları test etmek için, dosya indirmelerinin kolay kıyaslamasını sağlayan Node.js ile yazılmış küçük bir CLI yardımcı programıdır. Bir aralık, test uzunluğu belirtmenizi sağlar ve sonuçları bir CSV dosyasına çıktılar.

Installation

npm install cdn-bench


Usage

node cdn-bench \
    --files [file1,file2,...] \
    --interval [seconds between tests] \
    --limit [number of iterations] \
    --out [output filename]
    


node cdn-bench \
    --files http://example.com/image.png,http://example.com/image2.png \
    --interval 300 \
    --limit 288 \
    --out results.csv
