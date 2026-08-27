<div align="center">

# DUBAI ROLEPLAY V2

### A production-oriented, FiveM-inspired roleplay framework for open.mp

[![open.mp](https://img.shields.io/badge/RUNTIME-open.mp-00D4FF?style=for-the-badge)](https://www.open.mp/)
[![Pawn](https://img.shields.io/badge/LANGUAGE-Pawn-F5A623?style=for-the-badge)](https://github.com/pawn-lang/compiler)
[![MySQL](https://img.shields.io/badge/DATABASE-MySQL-00758F?style=for-the-badge&logo=mysql&logoColor=white)](https://www.mysql.com/)
[![MIT](https://img.shields.io/badge/LICENSE-MIT-8B5CF6?style=for-the-badge)](LICENSE)

[![Turf Control](https://img.shields.io/badge/TURF-CONTROL-FF1744?style=flat-square)](#about)
[![FiveM Marking](https://img.shields.io/badge/FIVEM-MARKING-00C853?style=flat-square)](#about)
[![Custom Textdraws](https://img.shields.io/badge/CUSTOM-TEXTDRAWS-FF6D00?style=flat-square)](#about)
[![Dynamic Showroom](https://img.shields.io/badge/DYNAMIC-SHOWROOM-7C4DFF?style=flat-square)](#about)
[![Grinding](https://img.shields.io/badge/ROLEPLAY-GRINDING-00B0FF?style=flat-square)](#about)
[![Threaded Queries](https://img.shields.io/badge/MYSQL-THREADED-00897B?style=flat-square)](#about)
[![Dialogs](https://img.shields.io/badge/UI-DIALOGS-EC407A?style=flat-square)](#about)
[![open source](https://img.shields.io/badge/SOURCE-PUBLIC-43A047?style=flat-square)](LICENSE)

</div>

---

## About

**Dubai Roleplay V2** is a production-oriented roleplay framework developed for open.mp, combining the accessibility of the Pawn ecosystem with the presentation and gameplay direction commonly associated with modern FiveM communities. Its architecture is supported by persistent MySQL storage and a progression-led gameplay model in which accounts, organizations, territories, vehicles, properties, businesses, inventories, and the wider economy operate as parts of a unified environment.

The project places particular emphasis on interface quality and operational flexibility. Purpose-built textdraws, animated notifications, structured dialogs, and a FiveM-inspired world-marking system provide a consistent player experience across its principal workflows. Its territory framework introduces advanced turf controllability through influence, competitive capture states, alliances, configurable safeguards, rewards, locking controls, and persistent gang storage. Vehicle commerce is delivered through a fully dynamic showroom system supporting managed inventories, categorized selections, configurable pricing, visual previews, and in-game dealership administration.

Beyond its player-facing systems, Dubai Roleplay V2 incorporates a modular technical foundation built around hooks, callback-driven services, threaded database queries, streamed world entities, Discord connectivity, configurable security controls, and comprehensive administrative tooling. The repository is therefore suitable both as a deployable roleplay gamemode and as an extensible engineering base for communities seeking to establish a distinct server identity without developing an entire platform from first principles.

The project originated from **[AKRP V5](https://github.com/najuaircrack/AKRP-V5), created by [najuaircrack](https://github.com/najuaircrack)**. That foundation was subsequently subjected to extensive rescripting and system development, resulting in Dubai Roleplay V2 as a separate technical and creative direction with original interfaces, gameplay systems, operational tooling, and an open.mp-oriented architecture.

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

Dubai V3 is neither affiliated with nor relevant to this release. Dubai Roleplay V2 represents my development work, and this repository constitutes its official public source. The decision to publish it followed the unauthorized circulation and commercial distribution of the script by members associated with the Dubai server management and team, none of whom had received my permission to leak, redistribute, or sell the project.

Official publication ensures that the authentic source, its development history, and its contributor acknowledgements remain available without dependence on unauthorized intermediaries. Any attempt to reintroduce this public code into a private server, remove its attribution, or represent the work as an independent creation will be readily contradicted by the public record established through this repository.

To the Dubai management and its associated team: the source is now public, the record is permanent, and responsibility for any future project rests entirely with you. I wish you every success in producing work of your own.

## License

Released under the [MIT License](LICENSE). This official release may be used, modified, and distributed under the license terms with the required copyright and permission notice preserved. Third-party dependencies may use separate licenses.

---

<div align="center">

**Dubai Roleplay V2 - released by the developers, not the sellers.**

</div>
