import TCPPortChecker, * as checker from "./checker";

(async () => {
  let c = new TCPPortChecker();
  console.log(await c.executeCheck(22, "google.com"));
})();
