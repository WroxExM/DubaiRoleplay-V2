# Dubai Roleplay V2

An open-source, feature-rich roleplay gamemode built for [open.mp](https://www.open.mp/) with Pawn and MySQL. Dubai Roleplay V2 combines a mature RP foundation with custom interfaces, territory warfare, modern navigation, dynamic vehicle showrooms, and extensive administration tools.

![Runtime](https://img.shields.io/badge/runtime-open.mp-2563eb?style=for-the-badge)
![Language](https://img.shields.io/badge/language-Pawn-f59e0b?style=for-the-badge)
![Database](https://img.shields.io/badge/database-MySQL%20R41+-4479a1?style=for-the-badge)
![License](https://img.shields.io/badge/license-MIT-16a34a?style=for-the-badge)

> A community release: study it, run it, improve it, and contribute back while preserving the required credits and third-party notices.

## What is Dubai Roleplay V2?

Dubai Roleplay V2 is the second major version of the Dubai Roleplay gamemode. It is a complete server foundation rather than a minimal starter script. Its interconnected systems cover character progression, factions, gangs, territory control, properties, businesses, vehicles, jobs, criminal activities, staff management, Discord logging, and a large custom user interface.

The project targets open.mp while retaining compatibility with the established SA-MP ecosystem and its commonly used Pawn libraries.

## What is the project based on?

The original foundation is **AKRP V5 by [najuaircrack](https://github.com/najuaircrack/AKRP-V5)**. Dubai Roleplay V2 expands that base through substantial rescripting, new systems, custom textdraws, mappings, performance work, and server-specific gameplay developed during live operation.

This repository does not claim ownership of AKRP V5 or third-party libraries. Their respective authors retain credit and ownership of their work.

## Why is this script unique?

Dubai Roleplay V2 is not a collection of disconnected commands placed on top of an old roleplay base. It is an extensively reworked, open.mp-focused gamemode in which the interface, world systems, economy, organizations, vehicles, and administration tools operate as one connected environment. Years of live-server development have shaped it into a practical foundation that can support a serious roleplay community while remaining open to further development.

Its identity comes from systems rarely offered together in a single public Pawn project: an advanced turf-control experience, highly customized textdraw interfaces, a FiveM-inspired world-marking system, and a fully dynamic showroom that can be managed without hard-coding every vehicle. These are supported by streamed mappings, database-driven entities, detailed staff controls, Discord integration, configurable security, and performance tooling designed for a modern open.mp deployment.

## Core features

At its core is an advanced open.mp roleplay framework backed by MySQL. Player accounts, organizations, properties, businesses, vehicles, inventories, progression, criminal activities, and the wider economy persist as connected data rather than isolated features. The result is a world that server owners can expand and administer in-game instead of rebuilding the source for every routine change.

The gamemode's signature systems include competitive turf control with influence and rewards, custom animated textdraw experiences, FiveM-style location marking, dynamic vehicle showrooms, extensive faction and gang workflows, configurable anti-cheat protection, Discord activity logging, and optimized batch-loaded mapping. A broad set of staff and entity-management tools makes the project suitable both as a playable gamemode and as a development base for a deeply customized open.mp server.

## Why was it released as open source?

Dubai Roleplay V2 is being released publicly because unauthorized copies of the script were leaked, shared, and offered for sale without the owner's knowledge or permission. Work that was never authorized for redistribution was being circulated and monetized by third parties, creating confusion about its ownership, authenticity, and official source.

Instead of allowing unofficial sellers or private leaks to define the future of the project, the owner has chosen to make the genuine source available to everyone. This official open-source release establishes a transparent origin, preserves the correct credits, prevents others from claiming exclusive access to the script, and gives the community a legitimate version that can be studied and improved under the terms of its license.

No previous leak, resale, or private distribution should be interpreted as permission from the owner. This repository is the intentional public release of Dubai Roleplay V2; attribution to the original base and subsequent contributors must remain intact.

## Requirements

| Component | Recommended version |
|---|---|
| open.mp server | Current stable release |
| MySQL or MariaDB | MySQL 5.7+ / MariaDB 10+ |
| BlueG MySQL plugin | R41+ |
| Pawn compiler | Bundled in `pawno/` |

The project also relies on the bundled includes and plugins listed in `config.json`, including streamer, sscanf, Pawn.CMD, Whirlpool, ColAndreas, Discord Connector, profiler, regex, and textdraw-streamer.

## Installation

1. Clone or download this repository.
2. Create a database and import `databases/Dubai.sql`.
3. Add local database credentials to `mysql.ini`.
4. Configure the hostname, port, RCON settings, and Discord token in `config.json`.
5. Compile `gamemodes/Dubai-V2.pwn` with the bundled Pawn compiler.
6. Set `pawn.main_scripts` in `config.json` to the compiled `.amx` filename.
7. Start open.mp and review the console for database or plugin errors.

Example database setup:

```sql
CREATE DATABASE dubai_v2 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE dubai_v2;
SOURCE databases/Dubai.sql;
```

> Never commit database passwords, Discord tokens, RCON passwords, or other deployment secrets.

## Project structure

```text
components/             open.mp runtime components
databases/              database schema and SQL data
filterscripts/          optional filterscripts such as SampVoice
gamemodes/
  Dubai-V2.pwn          main gamemode source
  modules/              modular gameplay and server systems
include/                shared includes
pawno/                  Pawn compiler and compiler includes
plugins/                legacy plugin binaries
scriptfiles/            runtime data and configuration files
config.json             open.mp server configuration
mysql.ini               local database connection configuration
```

## Credits and acknowledgements

| Contributor | Contribution |
|---|---|
| [najuaircrack](https://github.com/najuaircrack) | Creator of [AKRP V5](https://github.com/najuaircrack/AKRP-V5), the original base |
| NeeLan ICNQ / NeelanX | Rescripting, main development, and textdraw work |
| WROX / WroxExM / ZpyRx | Development, dynamic showroom, systems, and custom textdraws |
| Razi / RaziScofield | Server and gamemode development |

Special thanks to the open.mp team and every author whose library or plugin is used by this project. Attribution within individual source files should be preserved. If a credit is incomplete, open a pull request with supporting information so it can be corrected.

## Contributing

Bug fixes, documentation improvements, compatibility updates, optimizations, and well-tested features are welcome. Keep pull requests focused, document database changes, avoid committing secrets or generated logs, and preserve original attribution.

## License

Dubai Roleplay V2 is distributed under the [MIT License](LICENSE). You may use, copy, modify, publish, and distribute the project subject to that license. Bundled plugins, components, includes, mappings, and other third-party assets may have separate licenses; verify their terms before redistribution or commercial use.

## Disclaimer

This software is provided as-is, without warranty. Server operators are responsible for securing their configuration, reviewing the code and dependencies, complying with third-party licenses, and following the rules applicable to their community and hosting environment.
