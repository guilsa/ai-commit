# AI Commit

A tool to generate git commit messages using AI.

# Dependencies

- Ollama (https://ollama.com/)
- llama3.2:3b

# Installation

Install Ollama and the llama3.2:3b model. Then clone this repository:

```bash
git clone git@github.com:guilsa/ai-commit.git
```

Then copy `ai-commit.sh` to a directory in your PATH, for example `~/.local/bin/`:

```bash
cp ai-commit/ai-commit.sh ~/.local/bin/ai-commit
chmod +x ~/.local/bin/ai-commit
```

# Functionality Checklist

- [ ] If there is nothing staged, it should quit with a message saying "No changes staged for commit."
- [ ] If the current folder is not a git repository, it should quit with a message saying "Not a git repository."
- [ ] Commit message with ! to draw attention to breaking change
- [ ] A longer commit body MAY be provided after the short description, providing additional contextual information about the code changes. The body MUST begin one blank line after the description. A commit body is free-form and MAY consist of any number of newline separated paragraphs.
- [ ] Automatically generating CHANGELOGs.
- [ ] Automatically determining a semantic version bump (based on the types of commits landed).

# Prior art

1. https://www.conventionalcommits.org/en/v1.0.0/
2. Original inspiration found [here](https://helius.dk/cheat-sheets/ollama/)