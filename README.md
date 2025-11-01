
# 🖥️ 💻  Vim e NeoVim como editor de texo/código. 


::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

  Neovim é uma versão melhorada do Vim tradicional, que tem suporte nativo para Lua, linguagem de programação brasileira muito versátil, e gerenciadores de plugins modernos como Lazy.nvim, por exemplo. Porém o Vim ainda é o editor de texto que vem por padão em muitas distribuições de sistemas operacionais com base no kernel do Linux, apesar de que o NeoVim é extremamente facil de instalar no terminal: 

```bash 
     sudo apt install neovim 

``` 



  Muitos usuários de terminal com filosofias de trabalho minimalista e/ou que precisam trabalhar em ambientes alheios, onde não encontram suas configurações/setup de trabalho (computadores diferentes), muitas vezes procuram um editor de texto com uma configuração mínima de personalização de trabalho. Nesse caso se não quiser instalar e carregar toda uma configuração do NeoVim, ele precisa apenas criar o arquivo '```.vimrc```', com suas configurações de trabalho no diretório home (```~/```). 

  As configurações disponibilizadas aqui são testadas, básicas e customizáveis. Todavia é preciso garantir edição correta do código, observando o que é compativel e o que pode causar conflitos, principalmente no Vim que é mais antigo. 


## Procedimento válido para: Linux; macOS (Unix); Windows via WSL (Windows Subsystem for Linux):

Instale o Vim e/ou NeoVim (caso não já esteja) :

```bash
	sudo apt-get install vim-gtk3 	# Instala versão com suporte a clipboard.
	
	sudo apt install neovim 	# Instala última versão disponível no repositório.
```
Baixe este repositório , "nvim", no diretório '```~/.config```' . Caso ele não existir crie-o ou baixe o repositório, criando ```~/.config``` ou direcionando para ele se já existir, da seguinte forma:

```bash
	git clone https://github.com/MaviMelo/nvim ~/.config/nvim
```	

  Caso o Vim e/ou NeoVim já estiver(em) instalado(s), para carregar essas configurações para o Vim e/ou NeoVim que já estão carregados com outras configurações, antes de mover o diretório ```nvim/``` (configurações para o ```NeoVim```) para a pasta ' ```.config/``` ' e/ou o arquivo ```.vimrc``` (configurações para o Vim) para o diretório home ( ```~/``` ) no sistema  operacional é preciso limpar as configurações antigas para não haver conflitos.
 
0) Se o computador não é seu e já tem configurações para o Vim e/ou NeoVim:

  0.1 Apenas use o/s editor/es, simples.

  0.2 Se por algum motivo você precisa usar suas configurações, faça um backup das configurações atuais: crie um diretório (pasta) de nome backupvim, por exemplo, e copie o arquivo .vimrc (caminho até o arquivo: ```~/.vimrc```) e/ou a pasta ```nvim``` (caminho até o diretório: ```~/.config/nvim```) para dentro ela.

```bash
	mkdir  ~/backupvim			           # cria o diretório. 

	cp -r -p  ~/.vimrc  ~/.config/nvim  ~/backupvim          # A opção -p mantém metadados (data
                                                             # de modificação e permissões).
```
  0.3 Após termino do trabalho reinstale as configurações anteriores refazendo a etapa "1. Remover as configurações e dados..." e copie ou mova os backups feitos para seus diretórios (pastas) de origem:

```bash
    cd ~/backupvim
    cp -r -p  .vimrc  ~/
    cp -r -p  nvim  ~/.config/
``` 
1) Remover as configurações e dados antigos ().

     1.1. Para o NeoVim (```bash: nvim ```)

```bash

	# Configurações principais
	rm -rf ~/.config/nvim

	# Dados, plugins e caches
	rm -rf ~/.local/share/nvim 	# Plugins e dados instalados
	rm -rf ~/.cache/nvim        	# Arquivos temporários/cache
	rm -rf ~/.local/state/nvim  	# Estado da sessão (opcional)

	# Opcional: reinstale o neovim (se houver problemas com a intalação)

	sudo apt purge neovim && sudo apt install neovim 	# no Linux / WSL
	brew reinstall neovim 			# no macOS (via Homebrew)
```

  1.2. Para o Vim (```bash: vim```)

```bash

	# Remove a pasta de configurações e plugins
	rm -rf ~/.vim
	
	# Remove os arquivos de configuração
	rm ~/.vimrc ~/.gvimrc   	  # .vimrc (config principal) e .gvimrc (config GUI)
	
	# Opcional: Remove histórico e sessões salvas
	rm ~/.viminfo
	
	# Opcional: reinstale o vim (se houver problemas com a intalação)
	sudo apt purge vim && sudo apt install vim 	# no Linux (Debian/Ubuntu/WSL)
	brew reinstall vim 				# no macOS (via Homebrew)
```    

2) ESTRUTURA DE ARQUIVOS (Linux/WSL/macOS):

2.1. Para Neovim (visão redusida e genérica):

```bash   
   ~/
    └── .config/
        └── nvim/
            ├── init.vim        #<-(configurações em VimScript)         
            └── lua/
                └── config.lua   #<-(configurações em Lua)
```

2.2. Para Vim tradicional:

```bash   
   ~/
    └── .vimrc                 #<-(configurações em VimScript)
```

3) APÓS INSTALAR, a partir do shell (no caso o bash):
  
  3.1. entre no Vim(```vim```): Executar '```:PlugInstall```' no modo normal (Esc) para instalar os plugins;

  3.2. Neovim(```nvim```): Executar '```:Lazy install```' no modo normal (Esc) para instalar os plugins;
 
  3.3. Executar o arquivo setup.sh para instalações de dependencias para o correto funcionamento das configurações do NeoVim:

```bash
        sudo bash -x ~/.config/nvim/setup.sh     # necessário permissão root (administrador).
```

4) OBSERVAÇÕES SOBRE COMPATIBILIDADE:

  Versões mais antigas do Vim não tem integração com clipboard (copiar e colar com o ambiente externo do editor). Verifique a versão (```vim --version```) e  procure por +clipboard ou +xterm_clipboard. Caso não tenha compatibilidade (-clipboard) é opcional usar outra versão do vim que tenha essa compatibilidade ainda que, nesse caso, faria mais sentido instalar/usar o NeoVim.

  Também é interesante resaltar que versões do NeoVim mais antigas  que a 'V0.10.0' tem uma dificuldade em ter um funcionamento satisfatório com mecanismos de lsp e linter, que  auxiliam na edição de código e mostrando os erros de sintaxe e lógica 

  Comandos para usar Vim com supote ao clipboard:

```bash

    apt list --installed | grep vim     # Listar pacotes do Vim instalados

    sudo apt purge vim                    # Remover o pacote (ex.: sudo apt purge <nome-do-pacote>)
    
    sudo apt install vim-gtk3          # Instalar versão com suporte ao clipboard
```

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::



## 🚀 Instalação

Clone o repositório e execute o script de instalação:

```bash
        git clone https://github.com/MaviMelo/nvim ~/.config/nvim

        sudo bash -x .config/nvim/setup.sh   # necessário permissão root
```




# Comandos e Funcionalidades Básicas do Vim e NeoVim

## Índice

1. [A Filosofia Modal do Vim/NeoVim](#1-a-filosofia-modal-do-vimneovm)

1. [Gerenciamento de Sessão e Arquivos](#2-gerenciamento-de-sess%C3%A3o-e-arquivos)

1. [Edição Básica e Navegação](#3-edi%C3%A7%C3%A3o-b%C3%A1sica-e-navega%C3%A7%C3%A3o)

1. [Busca e Substituição](#4-busca-e-substitui%C3%A7%C3%A3o)

1. [Navegação por Saltos (Jump List)](#5-navega%C3%A7%C3%A3o-por-saltos-jump-list)

1. [Gerenciamento de Buffers](#6-gerenciamento-de-buffers)

1. [Janelas (Splits)](#7-janelas-splits)

1. [Redimensionamento de Janelas](#8-redimensionamento-de-janelas)

1. [Abas (Tabs)](#9-abas-tabs)

1. [Netrw: Gerenciamento de Arquivos](#10-netrw-gerenciamento-de-arquivos)

1. [Netrw: Marcação e Cópia de Arquivos](#11-netrw-marca%C3%A7%C3%A3o-e-c%C3%B3pia-de-arquivos)

1. [Netrw: Movimentação de Arquivos](#12-netrw-movimenta%C3%A7%C3%A3o-de-arquivos)

1. [Configurações Essenciais (Bônus)](#13-configura%C3%A7%C3%B5es-essenciais-b%C3%B4nus)

---

## 1. A Filosofia Modal do Vim/NeoVim

O Vim é um **editor modal**. Dominar a transição entre os modos é o primeiro passo para a produtividade extrema.

### Os Quatro Modos Principais

| Modo | Propósito | Como Entrar | Como Sair (Voltar ao Normal) |
| --- | --- | --- | --- |
| **Normal** | Navegação e Comandos | `Esc` (Padrão) | N/A |
| **Inserção** | Digitar Texto | `i`, `a`, `o`, `O` | `Esc` ou `Ctrl`+`[` |
| **Visual** | Seleção de Texto | `v`, `V`, `Ctrl`+`V` | `Esc` |
| **Comando** | Executar Comandos (`:`) | `:` ou `/` | `Enter` (Executa) ou `Esc` (Cancela) |

### Atalhos para Entrar no Modo de Inserção

| Ação | Atalho (Modo Normal) | Explicação |
| --- | --- | --- |
| **Inserir Antes do Cursor** | `i` | **I**nsert. |
| **Inserir Após o Cursor** | `a` | **A**ppend. |
| **Inserir em Nova Linha Abaixo** | `o` | **O**pen new line below. |
| **Inserir em Nova Linha Acima** | `O` | **O**pen new line above. |

---

## 2. Gerenciamento de Sessão e Arquivos

Comandos básicos para iniciar e finalizar o trabalho, garantindo a segurança dos seus arquivos.

### Comandos Essenciais de Sessão

| Ação | Comando por Extenso | Abreviação | Atalho (Modo Normal) |
| --- | --- | --- | --- |
| **Entrar no Vim** | `vim <arquivo>` (no terminal) | `vi <arquivo>` | N/A |
| **Salvar** | `:write` | `:w` | N/A |
| **Sair** | `:quit` | `:q` | N/A |
| **Salvar e Sair** | `:writequit` | `:wq` ou `:x` | `ZZ` |
| **Sair sem Salvar** | `:quit!` | `:q!` | `ZQ` |

### Explicações Detalhadas

- **`:w`** - Salva as alterações no arquivo atual, mas não fecha o editor.

- **`:q`** - Fecha o Vim. Só funciona se não houver alterações não salvas.

- **`:wq`** - Salva as alterações e fecha o editor. É o comando mais comum para finalizar o trabalho.

- **`:x`** - Similar a `:wq`, mas um pouco mais inteligente: só salva se houver alterações.

- **`:q!`** - Força a saída e **descarta** todas as alterações desde o último salvamento. Use com cuidado!

- **`ZZ`** - Atalho para `:wq`. Pressione `Z` duas vezes no Modo Normal.

- **`ZQ`** - Atalho para `:q!`. Força a saída sem salvar.

---

## 3. Edição Básica e Navegação

Manipulação de texto com copiar, recortar, colar e histórico de alterações. Estes são os comandos fundamentais para edição eficiente de arquivos.

### Operações de Cópia, Recorte e Cola

| Ação | Atalho (Modo Normal) | Explicação |
| --- | --- | --- |
| **Copiar Linha** | `yy` | **(Y)ank** - Copia a linha inteira. |
| **Copiar Palavra** | `yw` | Copia uma palavra. |
| **Copiar Seleção** | `y` (no Modo Visual) | Copia o texto selecionado. |
| **Recortar Linha** | `dd` | **(D)elete** - Recorta a linha inteira (vai para o registrador). |
| **Recortar Palavra** | `dw` | Recorta uma palavra. |
| **Recortar Seleção** | `d` (no Modo Visual) | Recorta o texto selecionado. |
| **Colar Após o Cursor** | `p` | **(P)aste** - Cola o conteúdo do registrador após o cursor. |
| **Colar Antes do Cursor** | `P` | Cola o conteúdo do registrador antes do cursor. |
| **Copiar para o Clipboard (sitema)** | `"+y` | **(Y)ank** - copia o texto **para** o ambiente externo **do** editor (Ctrl + C). |
| **Colar do Clipboard (sitema)** | `"+p` | **(P)aste** - cola o texto **do** ambiente externo **no** editor (Ctrl + V).
 Obs.: versões antigas do vim não suportam essa função ('Ctrl + C' e 'Ctrl + V'). |

### 

Histórico de Alterações

| Ação | Atalho (Modo Normal) | Explicação |
| --- | --- | --- |
| **Desfazer** | `u` | **(U)ndo** - Desfaz a última alteração. Pressione múltiplas vezes para desfazer as anteriores. |
| **Refazer** | `Ctrl` + `R` | **(R)edo** - Refaz uma alteração desfeita com `u`. |
| **Repetir Última Ação** | `.` | Repete o último comando de edição. **Extremamente útil para automação!** |

### Notas Importantes

- **Recortar é o mesmo que Deletar no Vim:** Quando você usa `dd` ou `d`, o texto vai para o "registrador" (área de transferência do Vim), funcionando como um recorte.

- **O ponto (****`.`****) é poderoso:** Se você inseriu texto, deletou uma linha, ou fez qualquer alteração, pressione `.` para repetir exatamente a mesma ação.

---

## 4. Busca e Substituição

Ferramentas rápidas para encontrar padrões e realizar substituições em massa.

### Comandos de Busca

| Ação | Comando/Atalho | Explicação |
| --- | --- | --- |
| **Buscar para Frente** | `/palavra` | Busca pela `palavra`. Pressione `n` para a próxima ocorrência, `N` para a anterior. |
| **Buscar para Trás** | `?palavra` | Busca no sentido contrário do arquivo. |
| **Ir para Próxima Ocorrência** | `n` | Pula para a próxima ocorrência da última busca. |
| **Ir para Ocorrência Anterior** | `N` | Pula para a ocorrência anterior da última busca. |

### Comandos de Substituição

| Ação | Comando | Explicação |
| --- | --- | --- |
| **Substituir na Linha** | `:s/antigo/novo` | Substitui a **primeira ocorrência** na linha atual. |
| **Substituir Globalmente** | `:%s/antigo/novo/g` | Substitui **todas** as ocorrências no arquivo. |
| **Substituir com Confirmação** | `:%s/antigo/novo/gc` | Pede confirmação (`y/n/a/q`) para cada substituição. |

### Explicações Detalhadas

- **`/palavra`** - Pressione `Enter` para executar a busca. O cursor pulará para a primeira ocorrência.

- **`n`** - Vai para a próxima ocorrência. Pressione múltiplas vezes para navegar por todas.

- **`N`** - Vai para a ocorrência anterior (sentido contrário).

- **`:%s/antigo/novo/g`** - O `%` significa "todo o arquivo", `s` é "substitute", e `g` é "global" (todas as ocorrências).

- **`:%s/antigo/novo/gc`** - Ao pressionar `y`, substitui; `n` pula; `a` substitui todas as restantes; `q` cancela.

---

## 5. Navegação por Saltos (Jump List)

O Vim mantém um histórico de "saltos" que você faz no arquivo. Use-o para navegar rapidamente.

### Comandos de Jump List

| Ação | Atalho (Modo Normal) | Explicação |
| --- | --- | --- |
| **Saltar para Posição Anterior** | `Ctrl` + `O` | Volta para a posição do cursor **antes** do último "salto" (como o botão "Voltar" de um navegador). |
| **Avançar para Posição Seguinte** | `Ctrl` + `I` | Avança na lista de saltos (o oposto de `Ctrl+O`). |

### O que Conta como um "Salto"?

Um salto ocorre quando você:

- Realiza uma busca com `/` ou `?`

- Abre um novo arquivo com `:e` ou `:tabnew`

- Usa `gg` para ir ao início do arquivo

- Usa `G` para ir ao final do arquivo

- Usa `Ctrl+]` para ir para uma definição (com tags)

### Exemplo Prático

1. Você está na linha 50 de um arquivo.

1. Você busca `/função` e o cursor pula para a linha 200.

1. Você abre outro arquivo com `:e outro_arquivo.txt`.

1. Agora, pressione `Ctrl+O` para voltar à busca anterior (linha 200).

1. Pressione `Ctrl+O` novamente para voltar à linha 50.

1. Pressione `Ctrl+I` para avançar para a linha 200 novamente.

---

## 6. Gerenciamento de Buffers

Buffers são os arquivos carregados na memória. Gerencie-os para alternar rapidamente entre projetos e otimizar seu fluxo de trabalho.

### O que é um Buffer?

Um **buffer** é uma área na memória que contém o conteúdo de um arquivo que você está editando. Quando você abre um arquivo com `vim arquivo.txt`, o Vim lê o conteúdo e o carrega em um buffer. Todas as suas edições são feitas nesse buffer, e o arquivo no disco só é modificado quando você salva.

**Vantagem:** Você pode ter vários buffers abertos ao mesmo tempo, cada um contendo um arquivo diferente, sem precisar fechar e reabrir o Vim.

### Comandos de Gerenciamento de Buffers

| Ação | Comando por Extenso | Abreviação | Atalho (Modo Normal) |
| --- | --- | --- | --- |
| **Listar Buffers** | `:buffers` | `:ls` | N/A |
| **Ir para Próximo Buffer** | `:bnext` | `:bn` | N/A |
| **Ir para Buffer Anterior** | `:bprevious` | `:bp` | N/A |
| **Ir para Buffer por Número** | `:buffer <N>` | `:b <N>` | N/A |
| **Ir para Buffer por Nome** | `:buffer <nome>` | `:b <nome>` | N/A |
| **Ir para Buffer Alternativo** | `:buffer #` | `:b#` | `Ctrl` + `^` |
| **Fechar Buffer Atual** | `:bdelete` | `:bd` | N/A |

### Explicações Detalhadas

- **`:ls`** - Mostra todos os buffers abertos com seus respectivos números. Exemplo:
  - `1`, `2`, `3` são os números dos buffers.
  - `%` indica o buffer que está na janela atual.
  - `#` indica o buffer alternativo (o último que você visitou).
  - `a` indica que o buffer está ativo (carregado e visível).

- **`:bn`** - Vai para o próximo buffer na lista.

- **`:bp`** - Vai para o buffer anterior na lista.

- **`:b 2`** - Troca para o buffer número 2.

- **`:b outro`** - Troca para o buffer cujo nome comece com "outro" (use `Tab` para autocompletar).

- **`Ctrl+^`** - Atalho rápido para alternar entre o buffer atual e o buffer alternativo. **Um dos atalhos mais úteis!**

- **`:bd`** - Fecha o buffer atual. Se o buffer tiver alterações não salvas, o Vim avisará. Use `:bd!` para forçar.

---

## 7. Janelas (Splits)

Divida a tela para ver e editar vários buffers simultaneamente. O prefixo para quase todos os comandos de janela é `Ctrl`+`W`.

### O que é uma Janela (Split)?

Uma **janela** (ou "split") é uma área visível na tela onde você vê um buffer. Você pode ter múltiplas janelas abertas, cada uma mostrando um buffer diferente (ou diferentes partes do mesmo buffer).

### Criando Splits

| Ação | Comando por Extenso | Abreviação | Atalho (Modo Normal) |
| --- | --- | --- | --- |
| **Split Horizontal** | `:split <arquivo>` | `:sp <arquivo>` | `Ctrl`+`W` `s` |
| **Split Vertical** | `:vsplit <arquivo>` | `:vsp <arquivo>` | `Ctrl`+`W` `v` |

### Navegando Entre Janelas

| Ação | Atalho (Modo Normal) | Explicação |
| --- | --- | --- |
| **Mover para Janela à Esquerda** | `Ctrl`+`W` `h` | Move o cursor para a janela à esquerda. |
| **Mover para Janela Abaixo** | `Ctrl`+`W` `j` | Move o cursor para a janela abaixo. |
| **Mover para Janela Acima** | `Ctrl`+`W` `k` | Move o cursor para a janela acima. |
| **Mover para Janela à Direita** | `Ctrl`+`W` `l` | Move o cursor para a janela à direita. |
| **Pular para Próxima Janela** | `Ctrl`+`W` `w` | Pula para a próxima janela (circulando por todas). |
| **Pular para Janela Anterior** | `Ctrl`+`W` `p` | Pula para a janela anterior. |

### Gerenciando Janelas

| Ação | Comando por Extenso | Abreviação | Atalho (Modo Normal) |
| --- | --- | --- | --- |
| **Fechar Janela Atual** | `:quit` | `:q` | `Ctrl`+`W` `q` |
| **Manter Apenas Janela Atual** | `:only` | N/A | `Ctrl`+`W` `o` |

### Exemplos Práticos

- **Abrir um arquivo em split horizontal:** `:sp arquivo.txt` (abre `arquivo.txt` em uma nova janela horizontal)

- **Abrir um arquivo em split vertical:** `:vsp script.js` (abre `script.js` em uma nova janela vertical)

- **Navegar entre splits:** Use `Ctrl+W` + `h/j/k/l` para mover entre as janelas como se fossem panes.

---

## 8. Redimensionamento de Janelas

Comandos para controlar o tamanho das janelas abertas. O prefixo é `Ctrl`+`W`.

### Ajustando Largura e Altura

| Ação | Atalho (Modo Normal) | Explicação |
| --- | --- | --- |
| **Aumentar Largura** | `Ctrl`+`W` `>` | Aumenta a largura da janela atual em 1 coluna. |
| **Diminuir Largura** | `Ctrl`+`W` `<` | Diminui a largura da janela atual em 1 coluna. |
| **Aumentar Altura** | `Ctrl`+`W` `+` | Aumenta a altura da janela atual em 1 linha. |
| **Diminuir Altura** | `Ctrl`+`W` `-` | Diminui a altura da janela atual em 1 linha. |
| **Igualar Tamanho** | `Ctrl`+`W` `=` | Deixa todas as janelas com a mesma altura e largura. |

### Usando Números para Ajustes Maiores

Você pode prefixar os comandos com um número para fazer ajustes maiores:

- **`10 Ctrl+W >`** - Aumenta a largura em 10 colunas.

- **`5 Ctrl+W +`** - Aumenta a altura em 5 linhas.

### Abrindo Netrw com Tamanho Específico

| Ação | Comando | Explicação |
| --- | --- | --- |
| **Abrir Netrw com Largura Específica** | `:30Lexplore` | Abre o Netrw em split vertical à esquerda com 30 colunas de largura. |
| **Abrir Netrw com Largura Específica (Direita)** | `:40Vexplore!` | Abre o Netrw em split vertical à direita com 40 colunas de largura. |

### Exemplo Prático

1. Você tem dois splits abertos lado a lado.

1. Você quer que o split da esquerda fique maior.

1. Pressione `Ctrl+W` `h` para mover para o split da esquerda.

1. Pressione `Ctrl+W` `>` múltiplas vezes para aumentar a largura, ou `10 Ctrl+W` `>` para aumentar 10 colunas de uma vez.

---

## 9. Abas (Tabs)

Abas são coleções de janelas, ideais para separar projetos ou tarefas. Navegue entre abas como em um navegador web.

### O que é uma Aba (Tab)?

Uma **aba** é um layout de janelas. Cada aba pode conter seu próprio conjunto de splits. Isso é diferente de buffers (que são arquivos em memória) e janelas (que são visualizações na tela). As abas permitem organizar completamente diferentes contextos de trabalho.

### Criando e Abrindo Abas

| Ação | Comando por Extenso | Abreviação | Atalho (Modo Normal) |
| --- | --- | --- | --- |
| **Nova Aba Vazia** | `:tabnew` | N/A | N/A |
| **Nova Aba com Arquivo** | `:tabnew <arquivo>` | `:tabe <arquivo>` | N/A |

### Navegando Entre Abas

| Ação | Comando por Extenso | Abreviação | Atalho (Modo Normal) |
| --- | --- | --- | --- |
| **Ir para Próxima Aba** | `:tabnext` | `:tabn` | `gt` |
| **Ir para Aba Anterior** | `:tabprevious` | `:tabp` | `gT` |
| **Ir para Aba Número N** | `:tabnext <N>` | `:tabn <N>` | `<N>gt` |
| **Ir para Primeira Aba** | `:tabfirst` | N/A | N/A |
| **Ir para Última Aba** | `:tablast` | N/A | N/A |

### Gerenciando Abas

| Ação | Comando por Extenso | Abreviação | Atalho (Modo Normal) |
| --- | --- | --- | --- |
| **Fechar Aba Atual** | `:tabclose` | `:tabc` | N/A |
| **Manter Apenas Aba Atual** | `:tabonly` | N/A | N/A |
| **Mover Aba para Posição** | `:tabmove <posição>` | N/A | N/A |

### Exemplos Práticos

- **Abrir um novo projeto em uma aba:** `:tabnew projeto2.txt`

- **Navegar entre abas:** Use `gt` para próxima e `gT` para anterior.

- **Ir para a terceira aba:** `3gt`

- **Mover a aba atual para o final:** `:tabmove`

- **Mover a aba atual para ser a primeira:** `:tabmove 0`

---

## 10. Netrw: Gerenciamento de Arquivos

Explorador de arquivos nativo do Vim. Crie, renomeie, delete, copie e mova arquivos e diretórios diretamente no editor.

### Abrindo o Netrw

| Ação | Comando | Explicação |
| --- | --- | --- |
| **Abrir Netrw na Janela Atual** | `:Explore` ou `:E` | Abre o Netrw mostrando o diretório atual. |
| **Abrir Netrw em Split Vertical (Esquerda)** | `:Lexplore` ou `:Lex` | Abre o Netrw em split vertical à esquerda (ótimo para sidebar). |
| **Abrir Netrw em Split Vertical (Direita)** | `:Vexplore` ou `:Vex` | Abre o Netrw em split vertical à direita. |
| **Abrir Netrw em Split Horizontal** | `:Sexplore` ou `:Sex` | Abre o Netrw em split horizontal. |

### Operações no Netrw

Os comandos abaixo são executados no Modo Normal dentro da janela do Netrw, com o cursor sobre o arquivo/diretório desejado.

| Ação | Atalho (no Netrw) | Explicação |
| --- | --- | --- |
| **Criar Diretório** | `d` | Pressione `d` e digite o nome do novo diretório. |
| **Criar Arquivo** | `%` | Pressione `%` e digite o nome do novo arquivo. |
| **Renomear** | `R` | Renomeia o arquivo/diretório sob o cursor. Digite o novo nome. |
| **Deletar** | `D` | Deleta o arquivo/diretório sob o cursor (pede confirmação). |
| **Marcar Arquivo** | `mf` | **(Mark File)** - Marca arquivo para operações em lote. Um `*` aparecerá. |
| **Desmarcar Arquivo** | `mu` | **(Mark Unseen)** - Remove a marcação do arquivo. |

### Exemplos Práticos

1. **Abrir o Netrw:** Digite `:Lexplore` para abrir como sidebar à esquerda.

1. **Criar um novo diretório:** Pressione `d` e digite `novo_projeto`.

1. **Criar um novo arquivo:** Pressione `%` e digite `script.py`.

1. **Renomear um arquivo:** Pressione `R` sobre o arquivo e digite o novo nome.

1. **Deletar um arquivo:** Pressione `D` sobre o arquivo e confirme.

---

## 11. Netrw: Marcação e Cópia de Arquivos

Operações avançadas de cópia de arquivos marcados no Netrw, permitindo gerenciamento eficiente de projetos.

### Marcar Arquivos e Diretórios (Pré-requisito)

| Ação | Atalho (no Netrw) | Explicação |
| --- | --- | --- |
| **Marcar Diretório de destino** | `mt` | **(Mark Target)** - Marca o diretório atual como o destino de arquivos movidos/copiados. |
| **Marcar Arquivo** | `mf` | **(Mark File)** - Marca o arquivo/diretório sob o cursor. Um `*` aparecerá ao lado do nome. |
| **Desmarcar Arquivo** | `mu` | **(Mark Unseen)** - Remove a marcação do arquivo (remove o `*`). |

**Nota:** Você pode marcar **múltiplos arquivos** antes de executar uma operação de cópia ou movimentação.

### Copiar Arquivos Marcados

| Ação | Atalho (no Netrw) | Explicação |
| --- | --- | --- |
| **Copiar Arquivos Marcados** | `mc` | **(Mark Copy)** - Copia os arquivos marcados para o diretório marcado com `mt`. |

### Processo Completo de Cópia

1. **Posicione o cursor** sobre os arquivos/diretórios que deseja copiar.

1. **Marque cada um** pressionando `mf`. Um `*` aparecerá ao lado de cada nome marcado.

1. **Navegue até o diretório de destino** usando as setas ou pressionando `Enter` para abrir pastas.

1. **Pressione ****`mc`** (Mark Copy). O Netrw pedirá confirmação para copiar os arquivos marcados para o local atual.

1. **Pressione ****`u`** para atualizar a visualização e ver os arquivos copiados.

### Exemplo Prático

```
Estrutura Original:
src/
  ├── arquivo1.txt
  ├── arquivo2.txt
  └── arquivo3.txt

backup/
  └── (vazio)

Processo:
1. Abra o Netrw: :Lexplore
2. Navegue para src/
3. Marque arquivo1.txt com mf
4. Marque arquivo2.txt com mf
5. Navegue para backup/
6. Pressione mc para copiar
7. Pressione u para atualizar

Resultado:
src/
  ├── arquivo1.txt
  ├── arquivo2.txt
  └── arquivo3.txt

backup/
  ├── arquivo1.txt
  └── arquivo2.txt
```

---

## 12. Netrw: Movimentação de Arquivos

Operações de movimentação de arquivos marcados no Netrw. Inclui avisos importantes sobre a irreversibilidade das operações.

### Mover Arquivos Marcados

| Ação | Atalho (no Netrw) | Explicação |
| --- | --- | --- |
| **Mover Arquivos Marcados** | `mm` | **(Mark Move)** - Move os arquivos marcados para o diretório atual. |

### Processo Completo de Movimentação

1. **Posicione o cursor** sobre os arquivos/diretórios que deseja mover.

1. **Marque cada um** pressionando `mf`. Um `*` aparecerá ao lado de cada nome marcado.

1. **Navegue até o diretório de destino** usando as setas ou pressionando `Enter` para abrir pastas.

1. **Pressione ****`mm`** (Mark Move). O Netrw moverá os arquivos marcados para o local atual.

1. **Pressione ****`u`** para atualizar a visualização. Os arquivos desaparecerão do local original.

### Exemplo Prático

```
Estrutura Original:
projeto_antigo/
  ├── arquivo1.txt
  ├── arquivo2.txt
  └── arquivo3.txt

projeto_novo/
  └── (vazio)

Processo:
1. Abra o Netrw: :Lexplore
2. Navegue para projeto_antigo/
3. Marque arquivo1.txt com mf
4. Marque arquivo2.txt com mf
5. Navegue para projeto_novo/
6. Pressione mm para mover
7. Pressione u para atualizar

Resultado:
projeto_antigo/
  └── arquivo3.txt

projeto_novo/
  ├── arquivo1.txt
  └── arquivo2.txt
```

### ⚠ Avisos Importantes

#### Operações Irreversíveis

Operações de arquivo no Netrw são **ações diretas no sistema de arquivos** e **NÃO podem ser desfeitas** com `u` (undo do Vim). Tenha cuidado ao deletar ou mover arquivos importantes!

#### Diferença: Undo do Vim vs. Sistema de Arquivos

- **`u`**** (undo) no Vim** desfaz apenas **edições de texto**, não operações de arquivo.

- Para recuperar arquivos deletados, você precisará usar ferramentas do sistema operacional (como `rm -r` no Linux ou Trash no macOS) ou backups.

#### Dica de Segurança

Antes de executar operações em lote no Netrw, considere:

- Fazer um backup dos arquivos importantes.

- Usar um sistema de controle de versão (como Git) para rastrear mudanças.

- Testar a operação com um arquivo menos importante primeiro.

---

## 13. Configurações Essenciais (Bônus)

Opções de configuração que melhoram a experiência de uso do Vim. Adicione essas linhas ao seu arquivo `.vimrc`.

### Configurações Básicas

| Ação | Comando de Configuração | Explicação |
| --- | --- | --- |
| **Mostrar Comandos Parciais** | `set showcmd` | Exibe teclas de comandos incompletos no canto inferior direito. Muito útil para aprender. |
| **Numeração de Linha** | `set number` | Mostra o número de cada linha na margem esquerda. |
| **Numeração Relativa** | `set relativenumber` | Mostra a distância das outras linhas em relação à linha atual. Ótimo para movimentos como `10j`. |
| **Realçar Resultados da Busca** | `set hlsearch` | Destaca todas as ocorrências encontradas em uma busca com `/` ou `?`. |
| **Tamanho Padrão do Netrw** | `let g:netrw_winsize = 30` | Define a largura padrão do Netrw para 30 colunas quando aberto com `:Lexplore`. |

### Exemplo de Arquivo .vimrc

```
" ============================================
" Configurações Essenciais do Vim
" ============================================

" Mostrar comandos parciais
set showcmd

" Destacar linha e coluna na posição do cursar.
set cursorcolumn 
set cursorline 

" ativar mouse para todas as janelas
set mouse=a

" tema nativo com bons contrastes.
colorscheme slate    " Se essa não estiver disponível, pressione Tab no comando ':colorscheme ' para ver os temas disponíveis.


" Numeração de linhas
set number
set relativenumber

" Realçar busca
set hlsearch

" Tamanho padrão do Netrw
let g:netrw_winsize = 30
```

### Onde Salvar o Arquivo .vimrc

#### Localizações por Sistema Operacional

| Sistema | Caminho |
| --- | --- |
| **Linux/macOS (Vim)** | `~/.vimrc` |
| **Linux/macOS (NeoVim)** | `~/.config/nvim/init.vim` |
| **Windows (Vim)** | `%USERPROFILE%\_vimrc` |
| **Windows (NeoVim)** | `%USERPROFILE%\AppData\Local\nvim\init.vim` |

### Como Recarregar as Configurações

Depois de editar o arquivo `.vimrc`, você pode recarregar as configurações de duas formas:

1. **Dentro do Vim:** Digite `:source ~/.vimrc` (ou o caminho correto para seu sistema).

1. **Feche e reabra o editor:** As configurações serão aplicadas automaticamente na próxima inicialização.

### Explicações Detalhadas

- **`set showcmd`** - Quando você digita um comando incompleto (como `d` esperando um movimento), o Vim mostra o que você digitou no canto inferior direito. Muito útil para aprender.

- **`set number`** - Mostra números de linha. Útil para referência e para usar comandos como `:10` (ir para a linha 10).

- **`set relativenumber`** - Mostra números relativos. A linha atual mostra `0`, a linha acima mostra `1`, a linha abaixo mostra `1`, etc. Isso torna movimentos como `5j` (descer 5 linhas) muito mais intuitivos.

- **`set hlsearch`** - Quando você busca algo com `/`, todas as ocorrências são destacadas. Pressione `:nohlsearch` para desativar o destaque temporariamente.

- **`let g:netrw_winsize = 30`** - Define a largura padrão do Netrw. Quando você abre com `:Lexplore`, o Netrw ocupará 30 colunas de largura.

---

## Resumo Rápido de Atalhos Essenciais

### Modos

- `i` - Entrar no Modo de Inserção (antes do cursor)

- `a` - Entrar no Modo de Inserção (após o cursor)

- `v` - Entrar no Modo Visual (caractere)

- `V` - Entrar no Modo Visual (linha)

- `Ctrl+V` - Entrar no Modo Visual (bloco)

- `Esc` - Voltar para o Modo Normal

### Edição

- `yy` - Copiar linha

- `dd` - Deletar/Recortar linha

- `"+Y` - Copiar texto selecionado para o clipboard

- `"+p` - Colar texto do clipboard 

- `p` - Colar após

- `P` - Colar antes

- `u` - Desfazer

- `Ctrl+R` - Refazer

- `.` - Repetir última ação

### Busca e Navegação

- `/palavra` - Buscar para frente

- `?palavra` - Buscar para trás

- `n` - Próxima ocorrência

- `N` - Ocorrência anterior

- `Ctrl+O` - Saltar para posição anterior

- `Ctrl+I` - Avançar para posição seguinte

### Buffers

- `:ls` - Listar buffers

- `:bn` - Próximo buffer

- `:bp` - Buffer anterior

- `:b <N>` - Buffer por número

- `Ctrl+^` - Alternar entre buffers

### Janelas (Splits)

- `Ctrl+W s` - Split horizontal

- `Ctrl+W v` - Split vertical

- `Ctrl+W h/j/k/l` - Navegar entre splits

- `Ctrl+W q` - Fechar split

- `Ctrl+W =` - Igualar tamanho

### Abas

- `:tabnew` - Nova aba

- `gt` - Próxima aba

- `gT` - Aba anterior

- `<N>gt` - Ir para aba N

- `:tabc` - Fechar aba

### Netrw

- `:Explore` - Abrir Netrw

- `:Lexplore` - Netrw em split vertical (esquerda)

- `d` - Criar diretório

- `%` - Criar arquivo

- `R` - Renomear

- `D` - Deletar

- `mf` - Marcar arquivo

- `mc` - Copiar marcados

- `mm` - Mover marcados

### Sessão

- `:w` - Salvar

- `:q` - Sair

- `:wq` ou `:x` - Salvar e sair

- `:q!` - Sair sem salvar

- `ZZ` - Salvar e sair (atalho)

- `ZQ` - Sair sem salvar (atalho)

---

## Dicas Finais

1. **Comece pelo básico:** Domine os modos e os comandos essenciais antes de explorar funcionalidades avançadas.

1. **Use ****`showcmd`****:** Adicione `set showcmd` ao seu `.vimrc` para ver os comandos que você está digitando. Isso acelera o aprendizado.

1. **Pratique diariamente:** Use o Vim para editar todos os seus arquivos por uma semana. Sua memória muscular se desenvolverá rapidamente.

1. **Use ****`.`**** para repetir:** O atalho `.` é extremamente poderoso. Se você fez uma edição, pressione `.` para repeti-la na próxima linha.

1. **Organize com abas e splits:** Use abas para separar projetos e splits para ver múltiplos arquivos lado a lado.

1. **Netrw é poderoso:** Você não precisa de plugins para gerenciar arquivos. O Netrw nativo é suficiente para a maioria das tarefas.

1. **Customize seu ****`.vimrc`****:** Comece com as configurações básicas e adicione mais conforme suas necessidades crescerem.

1. **Use Jump List:** `Ctrl+O` e `Ctrl+I` são seus melhores amigos para navegar rapidamente entre posições.

---

## Referências

- [Documentação Oficial do Vim](https://www.vim.org/docs.php)

- [Documentação Oficial do NeoVim](https://neovim.io/doc/)

- [Vim Tips Wiki](https://vim.fandom.com/wiki/Vim_Tips_Wiki)

---

**Última atualização:** Novembro de 2025

**Autor:** Tutorial Completo de Vim/NeoVim

**Licença:** Livre para uso e distribuição

