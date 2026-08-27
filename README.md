<div align="center">

# DUBAI ROLEPLAY V2

### An advanced FiveM-inspired roleplay gamemode for open.mp

[![open.mp](https://img.shields.io/badge/RUNTIME-open.mp-00D4FF?style=for-the-badge)](https://www.open.mp/)
[![Pawn](https://img.shields.io/badge/LANGUAGE-Pawn-F5A623?style=for-the-badge)](https://github.com/pawn-lang/compiler)
[![MySQL](https://img.shields.io/badge/DATABASE-MySQL-00758F?style=for-the-badge&logo=mysql&logoColor=white)](https://www.mysql.com/)
[![MIT](https://img.shields.io/badge/LICENSE-MIT-8B5CF6?style=for-the-badge)](LICENSE)

</div>

---

## About

**Dubai Roleplay V2** is a MySQL-powered open.mp gamemode built around a modern, FiveM-inspired roleplay experience. It features a progression-focused grinding system, advanced turf controllability, FiveM-style world marking, customized textdraw interfaces, dynamic vehicle showrooms, persistent organizations and properties, and complete in-game server management.

Originally based on **[AKRP V5](https://github.com/najuaircrack/AKRP-V5) by [najuaircrack](https://github.com/najuaircrack)**, the project was extensively rescripted and developed into Dubai Roleplay V2 with its own systems, interfaces, gameplay direction, and open.mp-focused architecture.

## Installation

1. Download or clone this repository.
2. Create a MySQL or MariaDB database.
3. Import [`databases/Clean.sql`](databases/Clean.sql).
4. Enter the database credentials in `mysql.ini`.
5. Configure the server, RCON password, and Discord token in `config.json`.
6. Compile `gamemodes/Dubai-V2.pwn` and place the resulting AMX in `gamemodes/`.
7. Set `pawn.main_scripts` in `config.json` to the compiled gamemode name.
8. Start the open.mp server.

```ini
hostname = 127.0.0.1
username = your_database_user
password = your_database_password
database = dubai_v2
server_port = 3306
```

> Do not publish database passwords, Discord tokens, RCON passwords, or other production credentials.

## Credits

| Contributor | Contribution |
|---|---|
| **[najuaircrack](https://github.com/najuaircrack)** | AKRP V5 original base |
| **NeeLan ICNQ / NeelanX** | Rescripting, development, and textdraws |
| **WROX / WroxExM / ZpyRx** | Development, systems, dynamic showroom, and textdraws |
| **Razi / RaziScofield** | Gamemode and server development |

Credits belonging to open.mp and the authors of all third-party plugins, includes, libraries, and mappings must be preserved.

## From the developer

I do not care about Dubai V3. Dubai Roleplay V2 is my project and this repository is its official public source. It was made public only after members of the Dubai server management and team circulated and sold the script without my permission.

So here it is—free and available to everyone. Do not take this public source back into your server, rename it, and pretend the work is yours. The history, code, and credits already speak for themselves.

To the Dubai management: have a good day. Do your own job this time.

## License

Released under the [MIT License](LICENSE). This official release may be used, modified, and distributed under the license terms with the required copyright and permission notice preserved. Third-party dependencies may use separate licenses.

---

<div align="center">

**Dubai Roleplay V2 — released by the developers, not the sellers.**

</div>
