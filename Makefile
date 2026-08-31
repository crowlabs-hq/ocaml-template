##
## @khalidbelk, 2026
## File description:
## Makefile
##

GREEN=\033[0;32m
RESET=\033[0m

NAME = new-project

all: $(NAME)

opam:
	dune build new-project.opam

deps: opam-deps

format:
	dune fmt

opam-deps:
	@echo "${GREEN}Installing dependencies...${RESET}"
	opam install . --deps-only --with-test || true

$(NAME):
	@echo "${GREEN}Building${RESET} $(NAME)..."
	@dune build --profile=release src/bin/main.exe
	@install -m 755 _build/default/src/bin/main.exe $(NAME)
	@strip $(NAME)
	@echo "${GREEN}✔ Done.${RESET}"

watch:
	@echo "${GREEN}Starting watcher...${RESET}"
	@dune build -w src/main.exe

clean:
	@echo "Cleaning..."
	@dune clean

fclean: clean
	@echo "${GREEN}Removing${RESET} $(NAME)..."
	@rm -f $(NAME)

re: fclean all

.PHONY: all clean