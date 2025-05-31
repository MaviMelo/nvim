#!/bin/bash

# ───────────────────────────────────────────────────────────────
# 📦 Script de Setup para Ambiente de Desenvolvimento com Linters
# Versões: Node.js, LuaRocks, Linters, e Nerd Font (FiraCode)
# ───────────────────────────────────────────────────────────────

# ▶️ Configurações
NODE_VERSION="18"       # Versão mínima do Node.js
LUAROCKS_VERSION="3.9.2"  # Versão do LuaRocks

# 🎨 Cores para saída no terminal
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
NC='\033[0m'  # No Color

# 🔍 Verifica se está sendo executado como root
check_root() {
    if [ "$(id -u)" -ne 0 ]; then
        echo -e "${RED}✖ Execute como sudo!${NC}"
        exit 1
    fi
}

# 📥 Instalação da Nerd Font FiraCode
install_nerd_font() {
    echo -e "${BLUE}▶ Instalando FiraCode Nerd Font...${NC}"
    FONT_DIR="$HOME/.local/share/fonts"
    mkdir -p "$FONT_DIR"

    # Baixa a última versão da FiraCode Nerd Font (Regular, Mono, Bold, Italic)
    TEMP_DIR=$(mktemp -d)
    cd "$TEMP_DIR"

    # Download do zip direto do repositório oficial
    wget -q https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip || {
        echo -e "${RED}✖ Falha ao baixar a Nerd Font${NC}"
        exit 1
    }

    unzip -q FiraCode.zip -d FiraCode
    cp FiraCode/*.ttf "$FONT_DIR" || {
        echo -e "${RED}✖ Falha ao copiar fontes para ${FONT_DIR}${NC}"
        exit 1
    }

    # Atualiza cache de fontes do sistema
    fc-cache -f "$FONT_DIR"

    echo -e "${GREEN}✔ FiraCode Nerd Font instalada com sucesso${NC}"
    cd ~ && rm -rf "$TEMP_DIR"
}

# 🛠️ Instalação do LuaRocks e luacheck
install_luarocks() {
    echo -e "${BLUE}▶ Verificando LuaRocks...${NC}"

    if ! command -v luarocks &>/dev/null; then
        echo -e "${YELLOW}✔ Instalando LuaRocks...${NC}"

        apt-get install -y lua5.3 liblua5.3-dev || {
            echo -e "${RED}✖ Falha ao instalar dependências do Lua${NC}"
            exit 1
        }

        wget -q https://luarocks.org/releases/luarocks-${LUAROCKS_VERSION}.tar.gz || {
            echo -e "${RED}✖ Falha ao baixar LuaRocks${NC}"
            exit 1
        }

        tar zxpf luarocks-${LUAROCKS_VERSION}.tar.gz && \
        cd luarocks-${LUAROCKS_VERSION} && \
        ./configure --with-lua-include=/usr/include/lua5.3 && \
        make && make install || {
            echo -e "${RED}✖ Falha na instalação do LuaRocks${NC}"
            exit 1
        }

        cd .. && rm -rf luarocks-${LUAROCKS_VERSION}*
        echo -e "${GREEN}✔ LuaRocks instalado com sucesso${NC}"
    else
        echo -e "${GREEN}✔ LuaRocks já instalado (${LUAROCKS_VERSION})${NC}"
    fi

    # Instala o luacheck via luarocks
    if ! luarocks list | grep -q "luacheck"; then
        luarocks install luacheck || {
            echo -e "${RED}✖ Falha ao instalar luacheck${NC}"
            exit 1
        }
        echo -e "${GREEN}✔ Luacheck instalado${NC}"
    else
        echo -e "${GREEN}✔ Luacheck já presente${NC}"
    fi
}

# 📦 Instala dependências básicas do ambiente
install_deps() {
    local deps=(git curl python3-pip php-cli shellcheck build-essential unzip)

    echo -e "${BLUE}▶ Verificando dependências...${NC}"
    apt-get update -qq

    for dep in "${deps[@]}"; do
        if ! dpkg -l | grep -q "^ii  ${dep} "; then
            echo -e "${YELLOW}✔ Instalando ${dep}...${NC}"
            apt-get install -y "${dep}" || {
                echo -e "${RED}✖ Falha ao instalar ${dep}${NC}"
                exit 1
            }
        fi
    done

    # Node.js moderno (NodeSource)
    if ! command -v node &>/dev/null || [ "$(node -v | cut -d'.' -f1 | tr -d 'v')" -lt ${NODE_VERSION} ]; then
        echo -e "${YELLOW}✔ Instalando Node.js LTS...${NC}"
        curl -fsSL https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash - && \
        apt-get install -y nodejs || {
            echo -e "${RED}✖ Falha ao instalar Node.js${NC}"
            exit 1
        }
    fi

    # Atualiza pip
#    python3 -m pip install --upgrade pip || {
#        echo -e "${RED}✖ Falha ao atualizar pip${NC}"
#        exit 1
#    }
}

# 🧹 Instalação global de linters
install_linters() {
    echo -e "${BLUE}▶ Instalando linters globais...${NC}"

    # JavaScript/TypeScript/CSS/HTML linters
    npm install -g \
        ts-node \
        typescript \
        eslint_d \
        @typescript-eslint/parser \
        @typescript-eslint/eslint-plugin \
        htmlhint \
        stylelint \
        stylelint-config-standard \
        jsonlint \
        prettier || {
            echo -e "${RED}✖ Falha ao instalar pacotes npm${NC}"
            exit 1
        }

    # Linters Python
#   pip3 install --upgrade pylint flake8 || {
#      echo -e "${RED}✖ Falha ao instalar linters Python${NC}"
#        exit 1
#   }
     
    # PHP CodeSniffer
    if ! command -v phpcs &>/dev/null; then
        wget -q -O /usr/local/bin/phpcs https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar && \
        chmod +x /usr/local/bin/phpcs || {
            echo -e "${RED}✖ Falha ao instalar phpcs${NC}"
            exit 1
        }
    fi

    # ShellCheck (reforço, caso não esteja instalado)
    if ! command -v shellcheck &>/dev/null; then
        apt-get install -y shellcheck || {
            echo -e "${RED}✖ Falha ao instalar shellcheck${NC}"
            exit 1
        }
    fi
}

# 🎯 Pós-instalação: mostra versões
post_install() {
    echo -e "${GREEN}\n✅ Instalação Concluída!${NC}"
    echo -e "${BLUE}Versões instaladas:${NC}"

    declare -A tools=(
        ["Node.js"]="node --version"
        ["npm"]="npm --version"
        ["TypeScript"]="tsc --version"
        ["ESLint"]="eslint_d --version"
        ["Python"]="python3 --version"
        ["Pylint"]="pylint --version"
        ["PHP_CodeSniffer"]="phpcs --version"
        ["ShellCheck"]="shellcheck --version"
        ["LuaRocks"]="luarocks --version"
    )

    for tool in "${!tools[@]}"; do
        version=$(${tools[$tool]} 2>/dev/null | head -n1)
        if [ -n "$version" ]; then
            printf "%-20s: %s\n" "$tool" "$version"
        else
            echo -e "${RED}✖ $tool não está disponível${NC}"
        fi
    done

    echo -e "\n${GREEN}✔ Configure seu terminal para usar a FiraCode Nerd Font!${NC}"
    echo -e "${BLUE}→ Exemplo: No Alacritty ou WezTerm, configure 'FiraCode Nerd Font Mono'.${NC}"
}

# ⚙️ Execução principal
main() {
    check_root
    install_deps
    install_nerd_font
    install_luarocks
    install_linters
    post_install
}

main "$@"
