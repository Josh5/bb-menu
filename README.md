# bb-menu

A BusyBox-compatible, standalone text-based menu system written in POSIX shell. Designed for ultra-lightweight Linux systems with minimal tools, this tool allows developers to build nested, script-driven UI menus using nothing more than shell scripts and a simple directory structure.

## 🧠 Why This Exists

Many minimalist Linux environments (like embedded consoles and retro handhelds) don't have access to dialog, ncurses, or Python. `bb-menu` was created to fill that gap by offering:

- A full-screen, keyboard-navigable menu interface
- Zero dependencies outside of BusyBox (ash, awk, grep, etc.)
- A file-based system for building modular, extensible UI structures

---

## 📁 Directory Structure

A complete menu system looks like this:

```
menus/
├── main/
│   ├── menu.ini
│   └── items/
│       ├── 10-system-info.sh
│       ├── 20-date-time.sh
│       ├── 30-disk-usage.sh
│       └── 99-fun-tools.sh
├── fun-tools/
│   ├── menu.ini
│   └── items/
│       ├── countdown.sh
│       └── joke.sh
```

- The root directory (e.g. `menus/`) is passed to a `bb-menu` launcher script.
- The launcher will open `main/menu.ini` by default.
- Each subdirectory (e.g. `fun-tools/`) is a submenu.

See the provided [`example`](./example/menus) directory for a working demonstration. Try it out:

```sh
./bb-menu ./example/menus/main
```

---

## 🗂️ `menu.ini` Reference

Each `menu.ini` configures one menu. Supported fields:

| Key               | Description                                         |
| ----------------- | --------------------------------------------------- |
| `menu_title=`     | Title shown at the top of the menu box              |
| `exit_title=`     | Label for the last item (defaults to `Quit`)        |
| `hide_exit_item=` | Set to `true` to hide the final exit/back menu item |

---

## 📝 Script Header Format (`*.sh`)

Each menu item is just a shell script in an `items/` directory. It should include a structured comment header:

```sh
#!/bin/sh
# title: My Tool
# description: This does something useful
```

These headers are parsed by `bb-menu` to generate menu entries automatically.

### Setting the order of menu items:

Scripts in each menu are parsed in alphanumeric order by filename, so you can control the display order using numeric prefixes (e.g. 10-, 20-, 99-).

```
items/
├── 10-system-info.sh
├── 20-date-time.sh
├── 30-disk-usage.sh
└── 99-fun-tools.sh
```

This ensures consistent and predictable menu layouts.

### Script helpers

When a script is selected, it is **sourced in a new shell** and has access to these functions:

- `press_any_key_to_exit` – Prompts the user and exits the script cleanly.
- `launch_submenu "subdir-name"` – Launches another submenu in a sibling directory.

### Example script:

[`20-date-time.sh`](./example/menus/main/items/20-date-time.sh)

---

## 🧩 Adding a Submenu

To create a nested submenu:

1. Create a sibling folder (e.g. `fun-tools/`)
2. Add its own `menu.ini` and `items/`
3. Inside a script in the parent menu (e.g. `fun-tools.sh`), call:

```sh
launch_submenu fun-tools
```

This will invoke the submenu using the same `bb-menu` binary and environment.

Any command-line arguments passed to the parent menu will also be passed to the child submenu process.

### Example script:

[`99-fun-tools.sh`](./example/menus/main/items/99-fun-tools.sh)

---

## ▶️ Launching

From your shell:

```sh
./bb-menu ./menus/main
```

With options:

```sh
./bb-menu --exit-title=Back ./menus/main
```

These are passed through as environment variables like `BB_MENU_EXIT_TITLE`, etc.

---

## 🧼 Notes

- `bb-menu` works in BusyBox environments (ash + coreutils only)
- Menu items are auto-discovered via headers — no manual exec entries needed
- All subprocesses source the same `bb-menu` script to access shared helpers
