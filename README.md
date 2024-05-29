# shell_config_files
Collection of shell configuration files.

# To-Do

- [ ] Add pre-commit hooks
    - [ ] Create and populate a `.pre-commit-hooks.yaml` file
    - [ ] Create a (preferably python) script for automatically installing
          these hooks without the user manually installing/running pre-commit.
    - [ ] Make one of these hooks a check for non-variable paths.
        - [ ] What's a good way to identify this?
        - [ ] How to make this a hook myself? Or is there already a path-wiping
              hook?
        - [ ] Could this be done using, e.g., cookiecutter or something
              similar?
- [ ] Add installer
    - [ ] Write a script that takes the directories in this folder with a given
          configuration file and make it an option on a CLI.
        - [ ] Dynamically find all directories with a given configuration file.
    - [ ] Determine a suitable configuration format for these files.
        - [ ] This should be in every shell configuration script.
        - [ ] Determine a standard & human-readable plaintext filetype to use.
            - [ ] YAML?
            - [ ] TOML?
            - [ ] JSON?
            - [ ] Something else?


# Glossary

<details>

### CLI

Command-Line Interface

### Configuration File

Also: **config file**, **config**

A file used for configuring a given shell script setup.

</details>
