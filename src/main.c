#include <stdio.h>
#include <ctype.h>
#include <string.h>
#include "formater.h"

int main()
{
    char text[100];
    char choice;

    printf("Enter text: ");
    if (fgets(text, sizeof(text), stdin) == NULL)
    {
        printf("Error reading input.\n");
        return 1;
    }
    if (strlen(text) >= sizeof(text) - 1)
    {
        printf("Input text is too long. Please enter less than 100 characters.\n");
        return 1;
    }
    text[strcspn(text, "\n")] = '\0'; // Remove newline character

    printf("Convert to (u)pper or (l)ower case? ");
    scanf(" %c", &choice);

    if (choice == 'u' || choice == 'U')
    {
        to_upper(text);
    }
    else if (choice == 'l' || choice == 'L')
    {
        to_lower(text);
    }
    else
    {
        printf("Invalid choice.\n");
        return 1;
    }

    printf("Converted text: %s\n", text);
    return 0;
}