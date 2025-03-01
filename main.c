#include "main.h"
#include <unistd.h>


#define MAX_ALIAS_SIZE 100

typedef struct alias {
    char *name;
    char *command;
    struct alias *next;
} alias_t;

alias_t *alias_list = NULL;

void free_aliases() {
    alias_t *temp;
    while (alias_list != NULL) {
        temp = alias_list;
        alias_list = alias_list->next;
        free(temp->name);
        free(temp->command);
        free(temp);
    }
}

void add_alias(char *name, char *command) {
    alias_t *new_alias = malloc(sizeof(alias_t));
    if (!new_alias) {
        perror("Failed to allocate memory for alias");
        return;
    }
    new_alias->name = strdup(name);
    new_alias->command = strdup(command);
    new_alias->next = alias_list;
    alias_list = new_alias;
}

char *get_alias(char *name) {
    alias_t *current = alias_list;
    while (current != NULL) {
        if (strcmp(current->name, name) == 0) {
            return current->command;
        }
        current = current->next;
    }
    return NULL;
}

int execute_builtin(char **argv) {
    if (strcmp(argv[0], "exit") == 0) {
        free_aliases();
        free(argv);
        return -1;
    }
    if (strcmp(argv[0], "cd") == 0) {
        if (argv[1] == NULL) {
            fprintf(stderr, "cd: expected argument\n");
        } else if (chdir(argv[1]) != 0) {
            perror("cd");
        }
        return 1;
    }
    if (strcmp(argv[0], "pwd") == 0) {
        char cwd[1024];
        if (getcwd(cwd, sizeof(cwd)) != NULL) {
            printf("%s\n", cwd);
        } else {
            perror("pwd");
        }
        return 1;
    }
    if (strcmp(argv[0], "echo") == 0) {
        for (int i = 1; argv[i] != NULL; i++) {
            printf("%s ", argv[i]);
        }
        printf("\n");
        return 1;
    }
    if (strcmp(argv[0], "clear") == 0) {
        printf("\033[H\033[J");
        return 1;
    }
    if (strcmp(argv[0], "alias") == 0) {
        alias_t *current = alias_list;
        if (argv[1] == NULL) {
            while (current != NULL) {
                printf("alias %s='%s'\n", current->name, current->command);
                current = current->next;
            }
        } else {
            char *alias_name = argv[1];
            char *alias_command = get_alias(alias_name);
            if (alias_command != NULL) {
                printf("alias %s='%s'\n", alias_name, alias_command);
            } else {
                printf("alias: %s not found\n", alias_name);
            }
        }
        return 1;
    }
    return 0;
}

int execute_external(char **argv) {
    pid_t pid = fork();
    if (pid == -1) {
        perror("fork");
        return 0;
    }
    if (pid == 0) {
        if (execvp(argv[0], argv) == -1) {
            fprintf(stderr, "%s: command not found\n", argv[0]);
            exit(1);
        }
    } else {
        int status;
        waitpid(pid, &status, 0);
    }
    return 1;
}

void suggest_command(char *cmd) {
    char *path = getenv("PATH");
    if (!path) {
      printf("%s: command not found\n", cmd);
        return;
    }

   
    char *path_copy = strdup(path);
    if (!path_copy) {
        perror("Failed to allocate memory for path copy");
        return;
    }

    char *token = strtok(path_copy, ":");


    printf("%s: command not found\n", cmd);
    printf("Did you mean:\n");

    
    int suggestions = 0;
    while (token != NULL) {
        char full_path[1024];
        snprintf(full_path, sizeof(full_path), "%s/%s", token, cmd);
        
        
        if (access(full_path, X_OK) == 0) {
            printf("    %s\n", full_path);
            suggestions++;
            if (suggestions >= 5) {  
                break;
            }
        }
        
        token = strtok(NULL, ":");
    }

    if (suggestions == 0) {
        printf("    (no suggestions)\n");
    }

    free(path_copy);
}


int main(int ac, char **argv) {
    (void)ac;
    setenv("SHELL", "./bitsh", 1);
    char *prompt = "$ ";
    char *lineptr = NULL;
    size_t n = 0;
    ssize_t len;
    char *lineptr_copy = NULL;
    const char *delim = " \n";
    int num_tokens = 0;
    char *token;
    int i;

    while (1) {
        printf("%s", prompt);

        len = getline(&lineptr, &n, stdin);

        if (len == -1) {
            printf("Exiting shell....\n");
            break;
        }

        lineptr_copy = malloc(sizeof(char) * len);
        if (lineptr_copy == NULL) {
            perror("bitsh: memory allocation error");
            break;
        }

        strcpy(lineptr_copy, lineptr);
        token = strtok(lineptr, delim);

        while (token != NULL) {
            num_tokens++;
            token = strtok(NULL, delim);
        }
        num_tokens++;

        argv = malloc(sizeof(char *) * num_tokens);
        if (argv == NULL) {
            perror("bitsh: memory allocation error");
            free(lineptr);
            free(lineptr_copy);
            break;
        }

        token = strtok(lineptr_copy, delim);

        for (i = 0; token != NULL; i++) {
            argv[i] = malloc(sizeof(char) * (strlen(token) + 1));
            if (argv[i] == NULL) {
                perror("bitsh: memory allocation error");
                free(lineptr);
                free(lineptr_copy);
                for (int j = 0; j < i; j++) {
                    free(argv[j]);
                }
                free(argv);
                break;
            }
            strcpy(argv[i], token);
            token = strtok(NULL, delim);
        }

        argv[i] = NULL;

        char *alias_command = get_alias(argv[0]);
        if (alias_command != NULL) {
            printf("Alias: %s -> %s\n", argv[0], alias_command);
            argv[0] = strtok(alias_command, delim);
        }

        if (execute_builtin(argv) == -1) {
            break;
        }

        if (execute_external(argv) == 0) {
            suggest_command(argv[0]);
            break;
        }

        for (i = 0; argv[i] != NULL; i++) {
            free(argv[i]);
        }
        free(argv);
    }

    free_aliases();
    free(lineptr);
    free(lineptr_copy);
    return 0;
}
