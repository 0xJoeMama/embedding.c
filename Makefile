CC=clang
EMBEDS=cat_pic.o
CFLAGS=-Wall -Werror -O3 -pedantic
NAME=embed-test
LD=ld
OBJ=main.o

all: $(NAME)

$(NAME): $(OBJ) $(EMBEDS)
	$(CC) $^ -o $(NAME)

%.o: %.jpg
	$(LD) -r -b binary $< -o $@

%.o: %.c
	$(CC) -c $(CFLAGS) -o $@ $<
