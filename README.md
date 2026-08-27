<div align="center">

# DUBAI ROLEPLAY V2

### Built on trust. Shaped by experience. Released for everyone.

An advanced, MySQL-powered roleplay framework engineered for **open.mp**.

[![Runtime](https://img.shields.io/badge/RUNTIME-OPEN.MP-00E5FF?style=for-the-badge&logo=rocket&logoColor=white)](https://www.open.mp/)
[![Language](https://img.shields.io/badge/LANGUAGE-PAWN-FFB000?style=for-the-badge&logoColor=white)](https://github.com/pawn-lang/compiler)
[![Database](https://img.shields.io/badge/DATABASE-MYSQL-00758F?style=for-the-badge&logo=mysql&logoColor=white)](https://www.mysql.com/)
[![License](https://img.shields.io/badge/LICENSE-MIT-7C3AED?style=for-the-badge)](LICENSE)

`TURF CONTROL` · `CUSTOM TEXTDRAWS` · `FIVEM-INSPIRED MARKING` · `DYNAMIC SHOWROOMS`

</div>

---

## This is not another public roleplay edit

Dubai Roleplay V2 is a complete open.mp roleplay environment built from years of development, experimentation, and real server experience. It brings gameplay, presentation, administration, and persistent world data together in one large Pawn codebase. The result is not a pack of random commands, but a connected framework ready to become the foundation of an ambitious roleplay community.

The gamemode began with **[AKRP V5](https://github.com/najuaircrack/AKRP-V5) by [najuaircrack](https://github.com/najuaircrack)** as its original base. From there, Dubai Roleplay V2 was extensively rescripted with a new identity: custom interfaces, advanced territory gameplay, dynamic server-owned systems, modern navigation, deeper administration, optimized mapping, and open.mp-focused improvements.

## What makes V2 different?

The difference is visible from the moment a player connects. Dubai Roleplay V2 replaces the feeling of a conventional Pawn gamemode with a heavily customized experience driven by purpose-built textdraws, animated notifications, interactive dialogs, and FiveM-inspired location marking. Its presentation is backed by persistent MySQL data and a world that can be managed dynamically instead of being rebuilt for every small change.

At the center of the experience is an advanced turf-control system created for meaningful gang conflict. Influence, captures, alliances, rewards, security rules, grace periods, locks, and territory stashes turn turf warfare into a complete gameplay loop rather than a simple checkpoint command.

The vehicle experience follows the same philosophy. Its fully dynamic showroom and dealership framework supports configurable vehicles, pricing, categories, previews, and in-game management. Alongside it are interconnected systems for factions, gangs, properties, businesses, inventories, crafting, vehicles, law enforcement, communication, staff operations, Discord logging, and anti-cheat protection.

Under the surface, the project makes extensive use of Pawn callbacks, hooks, threaded MySQL queries, streamed entities, modular includes, textdraw interfaces, and dialog-driven administration. It is designed both as a playable gamemode and as a serious codebase developers can study, reshape, and take further.

## A note from the developer

> **This script was created in good faith and handed to the Dubai Roleplay management and team on the strength of trust and loyalty. That trust was not respected.**

I am one of the developers behind Dubai Roleplay V2. The script was never given to the Dubai server management or its team with permission to leak it, redistribute it, or sell it. Despite that, copies were circulated and offered for sale without my knowledge or consent. Other people attempted to profit from work they did not have permission to distribute.

Once private copies had already been passed around, leaving the project closed would only reward those controlling and selling an unauthorized leak. I therefore made the decision to release the real source myself. If my work was going to reach the public, it would do so from the developer—not through somebody else's sale, claim, or betrayal of trust.

This repository is that official release. It establishes the authentic public source, keeps the development history and credits visible, and ensures nobody can pretend that access to Dubai Roleplay V2 belongs exclusively to them.

> **Loyalty gave this project a beginning. Betrayal gave it a public release. The community can decide what it becomes next.**

## Signature systems

| System | What it brings |
|---|---|
| **Turf Control** | Influence-based territory wars, captures, alliances, protection rules, rewards, locks, and gang stashes |
| **Custom UI** | Original login, registration, phone, banking, inventory, job, fuel, showroom, settings, and notification textdraws |
| **Marking System** | FiveM-inspired location and world marking for modern navigation and coordinated gameplay |
| **Dynamic Showrooms** | Configurable dealerships, vehicle previews, categories, prices, stock, and in-game administration |
| **Persistent World** | MySQL-backed players, vehicles, organizations, properties, businesses, inventories, and economy data |
| **Server Operations** | Discord logs, configurable anti-cheat, profiling, streamed mapping, and advanced staff management |

## Requirements

| Dependency | Version / note |
|---|---|
| [open.mp](https://www.open.mp/) | Current stable server release |
| MySQL or MariaDB | MySQL 5.7+ or MariaDB 10+ |
| BlueG MySQL plugin | R41+ |
| Pawn compiler | Included in `pawno/` |
| Runtime plugins | Supplied in `plugins/` and declared in `config.json` |

## Installation

### 1. Prepare the server

Clone or download the repository into a clean directory. Make sure the required open.mp components and legacy plugins can be loaded on your operating system.

```bash
git clone <your-repository-url> DubaiRoleplay-V2
cd DubaiRoleplay-V2
```

### 2. Import the clean database

Create a new database and import the release-ready schema from **`databases/Clean.sql`**. Do not use the original development database for a fresh public installation.

```sql
CREATE DATABASE dubai_v2
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE dubai_v2;
SOURCE databases/Clean.sql;
```

The same file can also be imported through phpMyAdmin, Adminer, HeidiSQL, or MySQL Workbench.

### 3. Configure MySQL

Open `mysql.ini` and enter the credentials for the database created above.

```ini
hostname = 127.0.0.1
username = your_database_user
password = your_database_password
database = dubai_v2
auto_reconnect = true
pool_size = 2
server_port = 3306
```

### 4. Configure open.mp

Review `config.json` before the first launch. At minimum, change the server name, network port, public address where required, RCON settings, and Discord bot token. Confirm that `pawn.main_scripts` matches the compiled gamemode filename.

```json
"pawn": {
  "main_scripts": [
    "Dubai-V2"
  ]
}
```

### 5. Compile the gamemode

Extract the compiler includes if your copy contains them as `pawno/include.rar`, then compile `gamemodes/Dubai-V2.pwn` using the bundled Pawn compiler. The resulting `Dubai-V2.amx` must remain inside `gamemodes/`.

### 6. Launch and verify

Start `omp-server` and inspect the console. A successful boot displays the Dubai Roleplay V2 credit box, connects to MySQL, loads the database-backed systems, and continues without missing-plugin or missing-table errors.

> Keep database passwords, Discord tokens, RCON passwords, and production configuration out of public commits.

## Repository layout

```text
DubaiRoleplay-V2/
├── components/             open.mp runtime components
├── databases/
│   └── Clean.sql           clean database for a fresh installation
├── filterscripts/          optional side scripts, including SampVoice
├── gamemodes/
│   ├── Dubai-V2.pwn        main gamemode source
│   └── modules/            marking, notifications, protection, and server modules
├── include/                shared includes
├── pawno/                  compiler and packaged compiler includes
├── plugins/                required legacy plugin binaries
├── scriptfiles/            runtime configuration and persistent script data
├── config.json             open.mp server configuration
└── mysql.ini               MySQL connection configuration
```

## Credits

| Name | Contribution |
|---|---|
| **[najuaircrack](https://github.com/najuaircrack)** | Creator of [AKRP V5](https://github.com/najuaircrack/AKRP-V5), the original base |
| **NeeLan ICNQ / NeelanX** | Rescripting, main development, and textdraw work |
| **WROX / WroxExM / ZpyRx** | Development, dynamic showroom, systems, and custom textdraws |
| **Razi / RaziScofield** | Server and gamemode development |

Respect is due to the open.mp team and the authors of every plugin, include, mapping, and library used by this project. Credits preserved inside individual source files form part of the project's history and should not be removed.

## License and attribution

Dubai Roleplay V2 is now intentionally released under the [MIT License](LICENSE). From this official release onward, the project may be used, modified, and redistributed under those terms. The copyright and permission notice must remain present in copies or substantial portions of the software.

This public license does not retroactively legitimize copies leaked, shared, or sold before the developer authorized this release. Third-party plugins, includes, components, mappings, and assets may remain subject to their own licenses.

## Contributing

Meaningful fixes, open.mp compatibility improvements, optimizations, documentation, and carefully tested systems are welcome. Keep changes focused, document database migrations, preserve attribution, and never commit credentials or generated server logs.

---

<div align="center">

### Dubai Roleplay V2 belongs in the hands of developers—not unauthorized sellers.

**Learn from it. Improve it. Give credit where it is due.**

</div>
