# Opengit

Opengit provides access for OpenComputers to download RAW files from Github.

---

## Pastebin ID

```pastebin
V9Ptwwx1
```

---

## Commands

### Config

Gets the OGIT-USR (Username), OGIT-REP (Repository), and OGIT-BRH (Branch) from OpenOS's enviornment variables.

```shell
ogit config
```

Sets the OGIT-USR (Username), OGIT-REP (Repository), and OGIT-BRH (Branch) from OpenOS's enviornment variables.

```shell
ogit config <user> <repo> <branch>
```

### Get

Downloads the specified file from Github. Uses the enviornment vairables provided by the Config command.

```shell
ogit get <file>
```

Downloads the specified file from Github. Required to input the username, repository, and branch.

```shell
ogit get <user> <repo> <branch> <file>
```
