db.currentOp(true).inprog.reduce(
  (accumulator, connection) => {
    ipaddress = connection.client ? connection.client.split(":")[0] : "Internal";
    accumulator[ipaddress] = (accumulator[ipaddress] || 0) + 1;
    accumulator["TOTAL_CONNECTION_COUNT"]++;
    return accumulator;
  },
  { TOTAL_CONNECTION_COUNT: 0 }
)
