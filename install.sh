#!/usr/bin/env bash
set -e

# ===============================
#  STATUS PAGE INSTALLER
#  MADE BY IamAman (dont copy)
# ===============================

# ---- Config ----
APP_DIR="/opt/statuspage"
SERVER_URL="https://raw.githubusercontent.com/IamGunpoint/statuspage/main/server.js"

# ---- Colors ----
GREEN="\e[32m"
CYAN="\e[36m"
YELLOW="\e[33m"
RED="\e[31m"
MAGENTA="\e[35m"
BOLD="\e[1m"
RESET="\e[0m"

clear

echo -e "${MAGENTA}${BOLD}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo " 🚀 STATUS PAGE INSTALLER"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "${RESET}"
echo -e " 🛠️  MADE BY ${BOLD}IamAman${RESET} ${RED}(dont copy)${RESET}\n"

# ---- Inputs ----
read -p "🏢 Enter Company Name: " COMPANY
read -p "🌐 Enter Website Address: " WEBSITE

echo -e "\n${CYAN}📌 Company:${RESET} $COMPANY"
echo -e "${CYAN}🔗 Website:${RESET} $WEBSITE\n"
sleep 1

# ---- Dependencies ----
echo -e "${YELLOW}⚙️  Checking system...${RESET}"

if ! command -v curl >/dev/null 2>&1; then
  apt update -y >/dev/null 2>&1
  apt install -y curl >/dev/null 2>&1
fi

if ! command -v node >/dev/null 2>&1; then
  echo -e "${CYAN}📦 Installing Node.js...${RESET}"
  curl -fsSL https://deb.nodesource.com/setup_20.x | bash - >/dev/null 2>&1
  apt install -y nodejs >/dev/null 2>&1
  echo -e "${GREEN}✅ Node.js installed${RESET}"
else
  echo -e "${GREEN}✅ Node.js already installed${RESET}"
fi

# ---- App Dir ----
mkdir -p "$APP_DIR"
cd "$APP_DIR"

# ---- Download server.js ----
echo -e "\n${CYAN}📥 Downloading server.js...${RESET}"

curl -fsSL "$SERVER_URL" -o server.js

if [ ! -f server.js ]; then
  echo -e "${RED}❌ Failed to download server.js${RESET}"
  exit 1
fi

# ---- npm ----
if [ ! -f package.json ]; then
  npm init -y >/dev/null 2>&1
fi

npm install express >/dev/null 2>&1

# ---- Branding ----
echo -e "${YELLOW}🧩 Applying branding...${RESET}"

sed -i "s/NexusNode/$COMPANY/g" server.js
sed -i "s/nexusnode.qzz.io/$WEBSITE/g" server.js
sed -i "s/iamaman/IamAman/g" server.js

echo -e "${GREEN}✅ Branding applied${RESET}\n"

# ---- Start ----
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e " 🟢 SERVER IS LIVE"
echo -e " 🏢 $COMPANY"
echo -e " 🌐 $WEBSITE"
echo -e " 📂 $APP_DIR/server.js"
echo -e " 🛠️  MADE BY IamAman (dont copy)"
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}\n"

node "$APP_DIR/server.js"
