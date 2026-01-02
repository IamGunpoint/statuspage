const express = require("express");
const app = express();

/* ================================
   CONFIG
================================ */
const PORT = 8888;

/*
  true  = ONLINE (green)
  false = OFFLINE (red)
*/
const SERVER_ONLINE = true;

/* ================================
   ROUTE
================================ */
app.get("/", (req, res) => {
  res.send(`<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>NexusNode Status</title>

<style>
* {
  box-sizing: border-box;
}

body {
  margin: 0;
  height: 100vh;
  background: radial-gradient(circle at top, #020617, #000);
  display: flex;
  justify-content: center;
  align-items: center;
  font-family: system-ui, -apple-system, BlinkMacSystemFont, sans-serif;
  color: #fff;
}

.card {
  background: #020617;
  width: 420px;
  padding: 32px;
  border-radius: 28px;
  text-align: center;
  box-shadow: 0 0 60px rgba(0,0,0,0.7);
}

.logo {
  width: 90px;
  height: 90px;
  object-fit: contain;
  margin-bottom: 16px;
}

.name {
  font-size: 30px;
  font-weight: 700;
  color: #3b82f6;
  margin-bottom: 6px;
}

.site {
  font-size: 14px;
  color: #94a3b8;
  margin-bottom: 26px;
}

.status {
  padding: 18px;
  border-radius: 22px;
  font-size: 20px;
  font-weight: 700;
  letter-spacing: 1px;
  background: ${SERVER_ONLINE ? "#16a34a" : "#dc2626"};
  box-shadow: 0 0 25px ${SERVER_ONLINE ? "rgba(22,163,74,.75)" : "rgba(220,38,38,.75)"};
}

.footer {
  margin-top: 22px;
  font-size: 13px;
  color: #64748b;
}

.footer span {
  color: #ef4444;
}
</style>
</head>

<body>
  <div class="card">
    <img
      class="logo"
      src="https://cdn-icons-png.flaticon.com/512/5968/5968322.png"
      alt="Server Logo"
    />

    <div class="name">NexusNode</div>
    <div class="site">nexusnode.qzz.io</div>

    <div class="status">
      ${SERVER_ONLINE ? "🟢 ONLINE" : "🔴 OFFLINE"}
    </div>

    <div class="footer">
      Made with <span>❤️</span> by iamaman
    </div>
  </div>
</body>
</html>`);
});

/* ================================
   START SERVER
================================ */
app.listen(PORT, "0.0.0.0", () => {
  console.log(`✅ NexusNode Status Page running on port ${PORT}`);
});
