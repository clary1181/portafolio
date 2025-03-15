<!-- esto es un comentario-->
# Práctica 1: Elementos básicos de los lenguajes de programación
#### El objetivo de esta práctica es identificar los elementos fundamentales de los lenguajes de programación: nombres, objetos, entornos, bloques, alcance, administración de memoria, expresiones, comandos, secuencia, selección, iteración, recursión, subprogramas, y tipos de datos.
<br>

**Código:** memory_management.h

**Nombres**

MEMORY_MANAGEMENT_H, MEMORY_MANAGEMENT_DISPLAY, heap_allocations, heap_deallocations, stack_allocations, stack_deallocations, displayMemoryUsage, incrementHeapAllocations, incrementHeapDeallocations, incrementStackAllocations, incrementStackDeallocations, pointer y size. Estos son nombres como identificadores que representan variables, macros y funciones.

**Objetos**
heap_allocations, heap_deallocations, stack_allocations, stack_deallocations, pointer y size.

**Entornos**
El entorno en este caso es el contexto de compilación y ejecución del código C. Como se puede notar en código las macros (#if, #define) modifican el código antes de la compilación.

**Bloques**  
 
Los bloques condicionales creados por #if MEMORY_MANAGEMENT_DISPLAY y #else son bloques de código.


```c
#if MEMORY_MANAGEMENT_DISPLAY
void displayMemoryUsage();
void incrementHeapAllocations(void *pointer, size_t size);
void incrementHeapDeallocations(void *pointer);
void incrementStackAllocations();
void incrementStackDeallocations();
#else
#define displayMemoryUsage() ((void)0)
#define incrementHeapAllocations(pointer, size) ((void)0)
#define incrementHeapDeallocations(pointer) ((void)0)
#define incrementStackAllocations() ((void)0)
#define incrementStackDeallocations() ((void)0)
#endif
```

**Alcance** 

* Variables globales: son accesibles desde cualquier archivo que incluya esta librería.
* Macros: Tienen alcance desde su definición hasta el final del archivo.
* Parámetros: Los parámetros de las funciones tienen alcance local dentro de la función.

**Administración de memoria** 

En este código esta las funciones incrementHeapAllocations, incrementHeapDeallocations, incrementStackAllocations, y incrementStackDeallocations están destinadas a actualizar los contadores de uso de memoria. 

**Expresiones**  

* (void)0) esta es una expresión que realiza una conversión a void y no devuelve ningún valor
* Las expresiones de #ifndef MEMORY_MANAGEMENT_DISPLAY son expresiones de preprocesamiento

**Comandos**  

#include, #define, #ifndef y #endif son comandos del preprocesador y declaraciones de variables y funciones.

**Secuencia** 

La secuencia de ejecución está determinada por el procesamiento de macros y las declaraciones de variables y funciones.

**Selección**  

La directiva #if MEMORY_MANAGEMENT_DISPLAY implementan la selección condicional de código.


**Iteración** 

No hay bucles en este código.

**Recursión** 

No hay recursiones en este código.

**Subprogramas** 

displayMemoryUsage, incrementHeapAllocations, incrementHeapDeallocations, incrementStackAllocations, y incrementStackDeallocations son subprogramas (funciones).

**Tipos de datos** 

int (para los contadores), void * (para el puntero), size_t (para el tamaño), y uso de #define crea tipos de datos simbólicos.

<br><br><br>
**Código:** biblioteca.c

**Nombres**

library, members, bookCount, memberCount, choice, static_var, bss_var, genre_t, book_t, member_t, genreToString, addBook, findBookById, displayBooksRecursive, displayBooks, addMember, issueBook, returnBook, freeLibrary, freeMembers, saveLibraryToFile, loadLibraryFromFile, saveMembersToFile, loadMembersFromFile, displayMembers, searchMember, main, incrementHeapAllocations, incrementHeapDeallocations. 

**Objetos**  

book_t y member_t son estructuras y cada libro o miembro creado es un objeto de esas estructuras.

**Entornos**

Incluye variables globales como static_var, bss_var y funciones; además de locales como variables dentro de las funciones, por ejemplo,  new_book, new_member, current. 

**Bloques**  

Bloques delimitados por llaves {} en funciones como bucles for, while, y sentencias switch.

```c
while (current_member) {
    if (current_member->id == memberID) {
        memberFound = current_member;
        break;
    }
    current_member = current_member->next;
}
``` 
```c
 while (current) {
     fprintf(file, "%d\n%s\n%d\n", current->id, current->name, current->issued_count);
     for (int i = 0; i < current->issued_count; i++) {
         fprintf(file, "%d\n", current->issued_books[i]);
     }
     current = current->next;
 }
``` 
Secciones delimitadas por llaves {} como addBook o displayBooks es un bloque.
```c

void addBook(book_t **library, int* count ) {
    // Asignacion de memoria en el heap
    book_t *new_book = (book_t *)malloc(sizeof(book_t));
    if (!new_book) {
        printf("Error al asignar memoria para el nuevo libro.\n");
        return;
    }
    incrementHeapAllocations(new_book, sizeof(book_t));
    printf("Memoria asignada para un nuevo libro (ID: %d) en el heap\n", new_book->id);

    printf("\nIngresa ID del libro: ");
    scanf("%d", &new_book->id);

    printf("Ingresa titulo del libro: ");
    getchar();
    fgets(new_book->title, 100, stdin);
    new_book->title[strcspn(new_book->title, "\n")] = '\0';

    printf("Ingresa nombre del autor: ");
    fgets(new_book->author, 100, stdin);
    new_book->author[strcspn(new_book->author, "\n")] = '\0';

    printf("Ingresa el ano de publicacion: ");
    scanf("%d", &new_book->publication_year);

    printf("Ingresa el genero del libro (0: FICTION, 1: NON_FICTION, 2: SCIENCE, 3: HISTORY, 4: FANTASY, 5: BIOGRAPHY, 6: OTHER): ");
    int genre;
    scanf("%d", &genre);
    new_book->genre = (genre_t)genre;

    printf("Ingresa la cantidad de libros: ");
    scanf("%d", &new_book->quantity);

    new_book->next = *library;
    *library = new_book;
    (*count)++;

    printf("\nEl libro fue agregado exitosamente!\n");
    displayMemoryUsage();
}
``` 
```c
void displayBooks(book_t *library) {
    if (!library) {
        printf("\nNo hay libros disponibles.\n");
        return;
    }

    printf("\nLibros disponibles en biblioteca:\n");
    displayBooksRecursive(library);
    displayMemoryUsage();
}
``` 
<br><br>

**Alcance** 

Las variables globales como library tienen un alcance global, mientras que las variables locales dentro de funciones tienen un alcance limitado a esa función.

**Administración de memoria** 

En el código, se utiliza malloc para asignar memoria para nuevos libros o miembros, y free para liberarla cuando ya no se necesita. 
 
* Memoria en el stack (variables locales en funciones).
```c
 // Variables automaticas (almacenadas en el stack)
 book_t *library = NULL;
 member_t *members = NULL;
``` 
* Memoria estática (variables static_var).
```c

// Variable estatica (almacenada en el segmento de datos)
static int static_var = 0;

// Variable del segmento BSS (variable global no inicializada)
int bss_var;
``` 
* Memoria en el segmento BSS (variables bss_var).
<br><br>

**Expresiones** 

Expresiones aritméticas
```c
bookFound->quantity--;
memberFound->issued_count++;
``` 
 
Expresiones de comparación 
```c
current_book->id == bookID && current_book->quantity > 0
``` 
```c
current_member->id == memberID
``` 

Expresiones de asignación 
```c
new_book->next = *library;
*library = new_book;
``` 
```c
new_member->next = *members;
*members = new_member;
``` 
 
Expresiones lógicas 
```c
if (bookFound && memberFound)
``` 
```c
if (!members) 
``` 
<br><br>
 
**Comandos**

#include, typedef, enum, struct, static, int, char, void, if, else, switch, while, for, return, malloc, free, realloc, printf, scanf, fgets, fopen, fclose, fprintf, fscanf, strcmp, strcspn. Estas son instrucciones que realizan acciones específicas. 

**Secuencia**
* Ejecución de comandos dentro de las funciones
* Orden de ejecución de las funciones dentro del main
  


**Selección**
* Sentencias if, else para la toma de decisiones
* Sentencia switch para selección múltiple basada en el género del libro y el sistema de manejo de la biblioteca
<br><br>

**Iteración**

Bucles while 
```c
while (current) {
    member_t *next = current->next;
    incrementHeapDeallocations(current->issued_books);
    free(current->issued_books);
    incrementHeapDeallocations(current);
    free(current);
    current = next;
}
``` 
```c
book_t *current_book = library;
while (current_book) {
    if (current_book->id == bookID) {
        bookFound = current_book;
        break;
    }
    current_book = current_book->next;
}

member_t *current_member = members;
while (current_member) {
    if (current_member->id == memberID) {
        memberFound = current_member;
        break;
    }
    current_member = current_member->next;
}
``` 
 
Bucles for 
```c
for (int i = 0; i < current->issued_count; i++) {
    book_t *book = findBookById(library, current->issued_books[i]);
    if (book) {
        printf("Libro ID: %d\nTitulo: %s\nAutor: %s\n", book->id, book->title, book->author);
    }
}
``` 
```c
for (int i = 0; i < memberFound->issued_count; i++) {
    if (memberFound->issued_books[i] == bookID) {
        found = 1;
        for (int j = i; j < memberFound->issued_count - 1; j++) {
            memberFound->issued_books[j] = memberFound->issued_books[j + 1];
        }
        memberFound->issued_count--;
        memberFound->issued_books = realloc(memberFound->issued_books, memberFound->issued_count * sizeof(int));
        incrementHeapAllocations(memberFound->issued_books, memberFound->issued_count * sizeof(int));
        printf("Memoria reasignada para los libros prestados del miembro (ID: %d) en el heap\n", memberFound->id);
        break;
    }
}
``` 
<br><br>

**Recursión**
Función displayBooksRecursive que muestra los libros de manera recursiva
```c
void displayBooksRecursive(book_t *library) {
    if (!library) {
        return;
    }
    printf("\nID libro: %d\nTitulo: %s\nAutor: %s\nAno de publicacion: %d\nGenero: %s\nCantidad: %d\n",
        library->id, library->title, library->author, library->publication_year, genreToString(library->genre), library->quantity);
    displayBooksRecursive(library->next);
}
``` 
<br>

**Subprogramas**

Funciones como addBook, displayBooks, issueBook, returnBook, freeLibrary, freeMembers, saveLibraryToFile, loadLibraryFromFile, saveMembersToFile, loadMembersFromFile, displayMembers, searchMember y genreToString, son subprogramas  que realizan tareas específicas. 
<br><br>

**Tipos  de datos**
Se utilizan tipos como int, char, struct, y enumeraciones como genre_t.
```c
int bss_var;

book_t *bookFound = NULL;
member_t *memberFound = NULL;
``` 
```c
typedef struct _book {
    int id;
    char title[100];
    char author[100];
    int publication_year;
    genre_t genre;
    int quantity;
    struct book *next;
} book_t;

typedef struct _member {
    int id;
    char name[100];
    int issued_count;
    int issued_books;
    struct member *next;
} member_t;
``` 
```c
book_t *library = NULL;
member_t *members = NULL;
int bookCount = 0, memberCount = 0;
int choice = 0;
``` 