# Como compilar e executar o servidor no Windows

Este guia foi feito para este projeto, que possui solucao do Visual Studio em `vc17`, dependencias via `vcpkg.json`, configuracao inicial em `config.lua.dist` e banco de dados em `bd.sql`.

## Programas necessarios

Instale:

1. Visual Studio 2022 ou Build Tools for Visual Studio 2022
   - Workload: `Desktop development with C++`
   - Toolset: `MSVC v143`
   - Windows 10/11 SDK

2. Git for Windows

3. vcpkg

4. MariaDB Server ou MySQL Server
   - Recomendado: MariaDB

5. Opcional
   - HeidiSQL, DBeaver ou phpMyAdmin para gerenciar o banco
   - OTClient compativel com Poketibia/TFS para conectar ao servidor

## 1. Instalar o vcpkg

Abra o PowerShell ou CMD e execute:

```bat
cd C:\
git clone https://github.com/microsoft/vcpkg.git
cd C:\vcpkg
bootstrap-vcpkg.bat
vcpkg integrate install
```

Depois configure a variavel de ambiente:

```bat
setx VCPKG_ROOT C:\vcpkg
```

Feche e abra novamente o terminal depois desse comando.

## 2. Usar o terminal correto do Visual Studio 2022

Para evitar erro de toolset, abra pelo Menu Iniciar:

```text
x64 Native Tools Command Prompt for VS 2022
```

Este projeto deve ser compilado com o toolset `v143` do Visual Studio 2022.

Se voce usar uma versao Preview ou mais nova do Visual Studio, o vcpkg pode tentar usar `v145/MSVC 19.51` e falhar ao compilar `boost-system`.

## 3. Instalar as dependencias do projeto

No terminal `x64 Native Tools Command Prompt for VS 2022`, execute:

```bat
cd C:\Users\NGXBRASIL\Downloads\PokeMonster
C:\vcpkg\vcpkg install --triplet x64-windows
```

O projeto usa o arquivo `vcpkg.json`, que instala dependencias como:

```text
boost
fmt
libmariadb
openssl
pugixml
cryptopp
lua
```

## 4. Corrigir erro de boost-system, se acontecer

Se aparecer erro parecido com:

```text
error: building boost-system:x64-windows failed with: BUILD_FAILED
Unsupported MSVC version: 1951
VCPKG_PLATFORM_TOOLSET=v145
```

significa que o vcpkg esta usando um compilador novo demais. Force o uso do Visual Studio 2022.

Para Visual Studio Community:

```bat
set VCPKG_VISUAL_STUDIO_PATH=C:\Program Files\Microsoft Visual Studio\2022\Community
cd C:\Users\NGXBRASIL\Downloads\PokeMonster
C:\vcpkg\vcpkg install --triplet x64-windows
```

Para Build Tools:

```bat
set VCPKG_VISUAL_STUDIO_PATH=C:\Program Files\Microsoft Visual Studio\2022\BuildTools
cd C:\Users\NGXBRASIL\Downloads\PokeMonster
C:\vcpkg\vcpkg install --triplet x64-windows
```

Se ainda falhar, limpe o pacote quebrado e tente novamente:

```bat
rmdir /s /q C:\vcpkg\buildtrees\boost-system
rmdir /s /q C:\vcpkg\packages\boost-system_x64-windows
cd C:\Users\NGXBRASIL\Downloads\PokeMonster
C:\vcpkg\vcpkg install --triplet x64-windows
```

## 5. Compilar o servidor no Visual Studio

Abra a solucao:

```text
vc17\theforgottenserver.sln
```

No Visual Studio, selecione:

```text
Release | x64
```

Depois compile:

```text
Build > Build Solution
```

Se a compilacao concluir com sucesso, o executavel sera gerado na raiz do projeto:

```text
theforgottenserver-x64.exe
```

## 6. Criar e importar o banco de dados

O arquivo do banco esta na raiz do projeto:

```text
bd.sql
```

Esse SQL ja cria e seleciona o banco `pke`:

```sql
CREATE DATABASE IF NOT EXISTS `pke`;
USE `pke`;
```

Importe o banco com:

```bat
mysql -u root -p < C:\Users\NGXBRASIL\Downloads\PokeMonster\bd.sql
```

Depois crie um usuario para o servidor:

```sql
CREATE USER 'pokemmonster'@'localhost' IDENTIFIED BY 'sua_senha';
GRANT ALL PRIVILEGES ON pke.* TO 'pokemmonster'@'localhost';
FLUSH PRIVILEGES;
```

## 7. Configurar o servidor

Na raiz do projeto existe:

```text
config.lua.dist
```

O servidor tenta copiar esse arquivo para `config.lua` na primeira execucao, caso `config.lua` ainda nao exista.

Edite o `config.lua` e ajuste principalmente:

```lua
ip = "127.0.0.1"

mysqlHost = "127.0.0.1"
mysqlUser = "pokemmonster"
mysqlPass = "sua_senha"
mysqlDatabase = "pke"
mysqlPort = 3306
```

O mapa configurado e:

```lua
mapName = "map"
```

E o arquivo do mapa fica em:

```text
data\world\map.otbm
```

## 8. Executar o servidor

Execute sempre pela raiz do projeto:

```bat
cd C:\Users\NGXBRASIL\Downloads\PokeMonster
theforgottenserver-x64.exe
```

O servidor precisa encontrar na mesma pasta:

```text
config.lua
data\
key.pem
```

## 9. Portas usadas

No `config.lua`, as portas principais sao:

```lua
loginProtocolPort = 7171
gameProtocolPort = 7172
statusProtocolPort = 7171
createCharacterPort = 7173
createAccountPort = 7174
```

Se for acessar de outra maquina na rede, libere no Firewall do Windows:

```text
TCP 7171
TCP 7172
TCP 7173
TCP 7174
```

Para testar localmente no client:

```text
IP: 127.0.0.1
Porta: 7171
```

## Observacoes

- O arquivo `steps.md` do projeto original contem instrucoes para Linux.
- No Windows, use preferencialmente a solucao `vc17\theforgottenserver.sln`.
- O projeto espera Visual Studio 2022 com toolset `v143`.
- Se o vcpkg tentar usar `v145/MSVC 19.51`, force o caminho do Visual Studio 2022 com `VCPKG_VISUAL_STUDIO_PATH`.
