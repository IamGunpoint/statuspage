#!/usr/bin/env bash

clear

# ===============================
#  MADE BY IamAman (dont copy)
# ===============================

# ---- Colors ----
GREEN="\e[32m"
CYAN="\e[36m"
YELLOW="\e[33m"
RED="\e[31m"
MAGENTA="\e[35m"
BOLD="\e[1m"
RESET="\e[0m"

echo -e "${MAGENTA}${BOLD}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo " 🚀 NEXUSNODE AUTO INSTALLER"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "${RESET}"
echo -e " ✨ MADE BY ${BOLD}IamAman${RESET} ${RED}(dont copy)${RESET}\n"

# ---- Inputs ----
read -p "🏢 Enter Company Name: " COMPANY
read -p "🌐 Enter Website Address: " WEBSITE

echo -e "\n${CYAN}📌 Company:${RESET} $COMPANY"
echo -e "${CYAN}🔗 Website:${RESET} $WEBSITE\n"
sleep 1

# ---- Node.js ----
echo -e "${YELLOW}⚙️  Checking Node.js...${RESET}"
if ! command -v node >/dev/null 2>&1; then
  echo -e "${CYAN}📦 Installing Node.js & npm...${RESET}"
  curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash - >/dev/null 2>&1
  sudo apt-get install -y nodejs >/dev/null 2>&1
  echo -e "${GREEN}✅ Node.js installed${RESET}\n"
else
  echo -e "${GREEN}✅ Node.js already installed${RESET}\n"
fi

# ---- npm init ----
if [ ! -f package.json ]; then
  echo -e "${CYAN}📄 Creating package.json...${RESET}"
  npm init -y >/dev/null 2>&1
fi

# ---- Express ----
echo -e "${CYAN}📥 Installing Express...${RESET}"
npm install express >/dev/null 2>&1
echo -e "${GREEN}✅ Express installed${RESET}\n"

# ---- Inject Company & Website ----
echo -e "${YELLOW}🧩 Configuring server branding...${RESET}"

sed -i "s/NexusNode/$COMPANY/g" server.js
sed -i "s/nexusnode.qzz.io/$WEBSITE/g" server.js
sed -i "s/iamaman/IamAman/g" server.js

echo -e "${GREEN}✅ Branding applied${RESET}\n"

# ---- Start Server ----
echo -e "${MAGENTA}🚀 Starting Server...${RESET}\n"
sleep 1

echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e " 🟢 SERVER IS LIVE"
echo -e " 🏢 $COMPANY"
echo -e " 🌐 $WEBSITE"
echo -e " 🛠️  MADE BY IamAman (dont copy)"
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}\n"

node server.js
