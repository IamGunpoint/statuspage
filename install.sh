#!/usr/bin/env bash
set -e

# ===============================
#  STATUS PAGE INSTALLER
#  MADE BY IamAman (dont copy)
# ===============================

# ---- Safety ----
if [ -z "$BASH_VERSION" ]; then
  echo "❌ Please run using bash"
  exit 1
fi

# ---- Config ----
APP_DIR="/opt/statuspage"
REPO_URL="https://github.com/IamGunpoint/statuspage.git"

# ---- Colors ----
GREEN="\e[32m"
CYAN="\e[36m"
YELLOW="\e[33m"
RED="\e[31m"
MAGENTA="\e[35m"
BOLD="\e[1m"
RESET="\e[0m"

clear

# ---- Banner ----
echo -e "${MAGENTA}${BOLD}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo " 🚀 STATUS PAGE AUTO INSTALLER"
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

if ! command -v git >/dev/null 2>&1; then
  echo -e "${CYAN}📦 Installing Git...${RESET}"
  apt update -y >/dev/null 2>&1
  apt install -y git >/dev/null 2>&1
fi

if ! command -v node >/dev/null 2>&1; then
  echo -e "${CYAN}📦 Installing Node.js & npm...${RESET}"
  curl -fsSL https://deb.nodesource.com/setup_20.x | bash - >/dev/null 2>&1
  apt install -y nodejs >/dev/null 2>&1
  echo -e "${GREEN}✅ Node.js installed${RESET}"
else
  echo -e "${GREEN}✅ Node.js already installed${RESET}"
fi

# ---- Clone Repo ----
echo -e "\n${CYAN}📥 Downloading Status Page...${RESET}"

if [ ! -d "$APP_DIR" ]; then
  git clone "$REPO_URL" "$APP_DIR" >/dev/null 2>&1
else
  echo -e "${YELLOW}⚠️  Existing install found, updating...${RESET}"
  cd "$APP_DIR"
  git pull >/dev/null 2>&1
fi

cd "$APP_DIR"

# ---- npm ----
if [ ! -f package.json ]; then
  npm init -y >/dev/null 2>&1
fi

npm install express >/dev/null 2>&1

# ---- Branding Injection ----
echo -e "${YELLOW}🧩 Applying branding...${RESET}"

sed -i "s/NexusNode/$COMPANY/g" server.js
sed -i "s/nexusnode.qzz.io/$WEBSITE/g" server.js
sed -i "s/iamaman/IamAman/g" server.js

echo -e "${GREEN}✅ Branding applied${RESET}\n"

# ---- Finish ----
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e " 🟢 SERVER IS LIVE"
echo -e " 🏢 $COMPANY"
echo -e " 🌐 $WEBSITE"
echo -e " 🛠️  MADE BY IamAman (dont copy)"
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}\n"

# ---- Start Server ----
node server.js
