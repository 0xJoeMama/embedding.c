CC=clang
CFLAGS=-Wall -Werror -O3 -pedantic
NAME=embed-test
LD=ld
SRC=$(wildcard *.c)
OBJ=$(patsubst %.c,%.o,$(SRC))
EMBEDS=cat_pic.o

all: $(NAME)
	@echo "Compilation done"

$(NAME): $(OBJ) $(EMBEDS)
	@echo "Linking binary" $@
	@$(CC) $^ -o $(NAME)

%.o: %.jpg
	@echo "Preparing" $< "for embedding"
	@$(LD) -r -b binary $< -o $@

%.o: %.c
	@echo "Compiling" $< "into" $@
	@$(CC) -c $(CFLAGS) -o $@ $<
