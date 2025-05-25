
<!-- esto es un comentario-->
# Práctica 2: Funionamiento del programa "biblioteca.py"
#### El objetivo de esta práctica es explicar de manera detallada cómo funciona el programa.
<br>

**Código:** biblioteca.py

**ESTRUCTURA DEL CÓDIGO**

* env/ (Entorno Virtual): Este directorio utiliza un entorno virtual de Python. Al activar este entorno antes de correr el programa, se garantiza la consistencia y reproducibilidad de la ejecución.

* src/ (Código Fuente): Este directorio comúnmente alberga el código fuente principal de la aplicación.

  * pycache: Guarda el bytecode compilado de los módulos .py en este directorio para acelerar la importación en ejecuciones posteriores.
  * static/: Contiene archivos estáticos utilizados por una interfaz web, como hojas de estilo CSS, archivos JavaScript, imágenes u otros recursos que se sirven directamente al navegador sin procesamiento dinámico.
  * templates/: Si el programa tiene una interfaz web, este directorio contendría los archivos de plantillas que definen la estructura y presentación de las páginas web dinámicas generadas por la aplicación.

  * biblioteca_web.py: Es la implementación de una interfaz web para la   biblioteca.
  * biblioteca.py: Contiene la lógica principal del sistema de gestión   de la biblioteca. 
  * memory_management.py: Contiene código relacionado con la gestión de   la memoria utilizada por la aplicación. Podría incluir   optimizaciones, estructuras de datos personalizadas para el   almacenamiento eficiente de la información de la biblioteca, o   mecanismos para liberar recursos cuando ya no son necesarios.

* Makefile.txt: Está diseñado para automatizar tareas dentro del proyecto. 
* requirements.txt: Este archivo es crucial para gestionar las dependencias del proyecto. Enumera todos los paquetes (bibliotecas) de Python que el proyecto necesita para funcionar correctamente. 
<br><br><br>

**biblioteca_web.py**


```python
from flask import Flask, request, jsonify, render_template
from memory_management import memory_management
from biblioteca import Book, DigitalBook, Member, Library, Genre

app = Flask(__name__)
library = Library()

# Cargar datos al iniciar la aplicación
library.load_library_from_file("library.json")
library.load_members_from_file("members.json")
``` 
* Importa módulos Flask para la funcionalidad web, un módulo para la gestión de memoria y clases del biblioteca.pyarchivo (como Book, *Member, Library).
  
* Crea una aplicación Flask ( app) y un Libraryobjeto para administrar * datos.
  
* Carga datos iniciales de la biblioteca desde archivos JSON.

<br><br>
```python
@app.route('/')
def index():
    return render_template('index.html')
``` 
* Maneja la página principal, mostrando una interfaz HTML.


<br><br>
```python
@app.route('/books', methods=['GET'])
def get_books():
    books = [book.to_dict() for book in library.books]
    return jsonify(books)
``` 
* Recupera todos los libros como una lista JSON (para API o visualización web).


<br><br>
```python
@app.route('/books', methods=['POST'])
def add_book():
    data = request.json
    # ... (Code to create Book or DigitalBook object)
    library.add_book(book)
    # ... (Code to save data and manage memory)
    return jsonify(book.to_dict()), 201
``` 
* Agrega un nuevo libro, que maneja tanto tipos de libros regulares como digitales.
* Guarda datos y administra la memoria después de agregarlos.


<br><br>
```python
@app.route('/members', methods=['GET'])
def get_members():
    members = [member.to_dict() for member in library.members]
    return jsonify(members)
``` 
* Recupera todos los miembros como una lista JSON.


<br><br>
```python
@app.route('/members', methods=['POST'])
def add_member():
    data = request.json
    # ... (Code to create Member object)
    library.add_member(member)
    # ... (Code to save data and manage memory)
    return jsonify(member.to_dict()), 201
``` 
* Agrega un nuevo miembro, guarda datos y administra la memoria.


<br><br>
```python
@app.route('/issue_book', methods=['POST'])
def issue_book():
    data = request.json
    # ... (Code to get book_id and member_id)
    library.issue_book(book_id, member_id)
    # ... (Code to save data and manage memory)
    return jsonify({"message": "Libro prestado satisfactoriamente!"})
``` 
* Se encarga de prestar un libro a un miembro.


<br><br>
```python
@app.route('/return_book', methods=['POST'])
def return_book():
    data = request.json
    # ... (Code to get book_id and member_id)
    library.return_book(book_id, member_id)
    # ... (Code to save data and manage memory)
    return jsonify({"message": "Libro devuelto satisfactoriamente!"})
``` 
* Se encarga de devolver un libro.


<br><br>
```python
@app.route('/save', methods=['POST'])
def save():
    library.save_library_to_file("library.json")
    library.save_members_to_file("members.json")
    memory_management.display_memory_usage()
    return jsonify({"message": "Datos guardados exitosamente!"})
``` 
* Guarda manualmente los datos de la biblioteca en archivos.


<br><br>
```python
@app.route('/load', methods=['POST'])
def load():
    library.load_library_from_file("library.json")
    library.load_members_from_file("members.json")
    memory_management.display_memory_usage()
    return jsonify({"message": "Datos cargados exitosamente!"})
``` 
* Carga manualmente datos de la biblioteca desde archivos.


<br><br>
```python
@app.route('/genres', methods=['GET'])
def get_genres():
    genres = Genre.all_genres()
    return jsonify(genres)
``` 
* Recupera una lista de géneros de libros.


<br><br>
```python
if __name__ == '__main__':
    app.run(debug=True)
``` 
* Inicia el servidor de desarrollo Flask en modo de depuración (solo para desarrollo).

<br><br><br>
**biblioteca.py**

```python
import json
from memory_management import memory_management
``` 
* import json:Importa el jsonmódulo que se utiliza para trabajar con datos JSON.
* from memory_management import memory_management:Importa el memory_managementmódulo, utilizado para rastrear la asignación y desasignación de memoria dentro de la aplicación.


<br><br>
```python
class Genre:
    '''Clase para definir los generos de los libros'''
    FICTION = "Ficcion"
    NON_FICTION = "No Ficcion"
    SCIENCE = "Ciencia"
    HISTORY = "Historia"
    FANTASY = "Fantasia"
    BIOGRAPHY = "Biografia"
    OTHER = "Otro"

    @classmethod
    def all_genres(cls):
        return [cls.FICTION, cls.NON_FICTION, cls.SCIENCE, cls.HISTORY, cls.FANTASY, cls.BIOGRAPHY, cls.OTHER]
``` 
* Esta clase define los géneros posibles para los libros.

<br><br>
```python
class Book:
    '''Clase para definir los libros de la biblioteca'''
    def __init__(self, book_id, title, author, publication_year, genre, quantity):
        self.id = book_id
        self.title = title
        self.author = author
        self.publication_year = publication_year
        self.genre = genre
        self.quantity = quantity
        memory_management.increment_heap_allocations(1)

    def __del__(self):
        memory_management.increment_heap_deallocations(1)

    def to_dict(self):
        '''Método para convertir los datos del libro en un diccionario'''
        return {
            "id": self.id,
            "title": self.title,
            "author": self.author,
            "publication_year": self.publication_year,
            "genre": self.genre,
            "quantity": self.quantity
        }

    @staticmethod
    def from_dict(data):
        '''Método para crear un objeto libro a partir de un diccionario'''
        return Book(
            int(data["id"]),
            data["title"],
            data["author"],
            int(data["publication_year"]),
            data["genre"],
            int(data["quantity"])
        )
``` 
* Esta clase representa un libro en la biblioteca.
* __init__El constructor inicializa el Bookobjeto con sus atributos ( book_id, title, author, publication_year, genre, quantity). También llama a , memory_management increment_heap_allocations(1)lo que sugiere que está rastreando cuántos Bookobjetos se crean.
* __del__El destructor __del__se llama cuando Bookse elimina un objeto (sale del ámbito). Se llama memory_management.increment_heap_deallocations(1)para rastrear las desasignaciones. Esto es útil para el análisis de la gestión de memoria.
* to_dict()Este método convierte los Bookatributos del objeto en un diccionario de Python. 
* from_dict()Esto @staticmethodcrea un Bookobjeto a partir de un diccionario. Es el inverso de to_dict()y se utiliza para reconstruir Bookobjetos a partir de datos.

<br><br>
```python
class DigitalBook(Book):
    '''Clase para definir los libros digitales de la biblioteca'''
    def __init__(self, book_id, title, author, publication_year, genre, quantity, file_format):
        '''Constructor de la clase DigitalBook'''
        super().__init__(book_id, title, author, publication_year, genre, quantity)
        self.file_format = file_format

    def to_dict(self):
        '''Método para convertir los datos del libro digital en un diccionario'''
        data = super().to_dict()
        data["file_format"] = self.file_format
        return data

    @staticmethod
    def from_dict(data):
        '''Método para crear un objeto libro digital a partir de un diccionario'''
        return DigitalBook(
            int(data["id"]),
            data["title"],
            data["author"],
            int(data["publication_year"]),
            data["genre"],
            int(data["quantity"]),
            data["file_format"]
        )
``` 
* Esta clase hereda de la Bookclase que representa un libro digital.
* __init__:El constructor llama al Bookconstructor de la clase super()para inicializar los atributos comunes y luego agrega el file_formatatributo específico para libros digitales.
* to_dict()Esto anula el método Bookde la clase to_dict()para incluir el file_format. Llama al método using Bookde la clase para obtener los atributos comunes y luego agrega el .to_dict()super()file_format
* from_dict():Esto @staticmethodcrea un DigitalBookobjeto a partir de un diccionario, similar al Bookde la clase from_dict().

<br><br>
```python
class Member:
    '''Clase para definir los miembros de la biblioteca'''
    def __init__(self, member_id, name):
        '''Constructor de la clase Member'''
        self.id = member_id
        self.name = name
        self.issued_books = []
        memory_management.increment_heap_allocations(1)

    def __del__(self):
        memory_management.increment_heap_deallocations(1)

    def to_dict(self):
        '''Método para convertir los datos del miembro en un diccionario'''
        return {
            "id": self.id,
            "name": self.name,
            "issued_books": self.issued_books
        }

    @staticmethod
    def from_dict(data):
        '''Método para crear un objeto miembro a partir de un diccionario'''
        member = Member(int(data["id"]), data["name"])
        member.issued_books = data["issued_books"]
        return member
``` 
* Esta clase representa a un miembro de la biblioteca.
* __init__Inicializa el Memberobjeto con member_idy namey crea una lista vacía issued_bookspara registrar los libros prestados por el miembro. También registra las asignaciones del montón.
* __del__:Realiza un seguimiento de las desasignaciones de montón.
* to_dict():Convierte los datos de los miembros en un diccionario.
* from_dict():Crea un Memberobjeto a partir de un diccionario.

<br><br>
```python
class Library:
    '''Clase para definir la biblioteca'''
    def __init__(self):
        '''Constructor de la clase Library'''
        self.books = []
        self.members = []
        memory_management.increment_heap_allocations(1)

    def __del__(self):
        memory_management.increment_heap_deallocations(1)

    def add_book(self, book):
        '''Método para agregar un libro a la biblioteca'''
        self.books.append(book)
        print("\nEl libro fue agregado exitosamente!\n")
        memory_management.display_memory_usage()

    def find_book_by_id(self, book_id):
        '''Método para buscar un libro por su ID'''
        for book in self.books:
            if book.id == book_id:
                return book
        return None

    def display_books(self):
        '''Método para mostrar los libros disponibles en la biblioteca'''
        if not self.books:
            print("\nNo hay libros disponibles.\n")
            return
        print("\nLibros disponibles en biblioteca:\n")
        for book in self.books:
            print(f"ID libro: {book.id}\nTitulo: {book.title}\nAutor: {book.author}\nAno de publicacion: {book.publication_year}\nGenero: {book.genre}\nCantidad: {book.quantity}\n")
            if isinstance(book, DigitalBook):
                print(f"Formato de archivo: {book.file_format}\n")
        memory_management.display_memory_usage()

    def add_member(self, member):
        '''Método para agregar un miembro a la biblioteca'''
        self.members.append(member)
        print("\nMiembro agregado exitosamente!\n")
        memory_management.display_memory_usage()

    def issue_book(self, book_id, member_id):
        '''Método para prestar un libro a un miembro'''
        book = self.find_book_by_id(book_id)
        member = self.find_member_by_id(member_id)
        print(f"\nDebug##book[{book}] member[{member}] \n")
        if book and member and book.quantity > 0:
            book.quantity -= 1
            member.issued_books.append(book_id)
            print("\nLibro prestado satisfactoriamente!\n")
        else:
            print("\nLibro o miembro no encontrados.\n")
        memory_management.display_memory_usage()

    def return_book(self, book_id, member_id):
        '''Método para devolver un libro prestado por un miembro'''
        book = self.find_book_by_id(book_id)
        member = self.find_member_by_id(member_id)
        if book and member and book_id in member.issued_books:
            book.quantity += 1
            member.issued_books.remove(book_id)
            print("\nLibro devuelto satisfactoriamente!\n")
        else:
            print("\nLibro o miembro no encontrados.\n")
        memory_management.display_memory_usage()

    def find_member_by_id(self, member_id):
        '''Método para buscar un miembro por su ID'''
        for member in self.members:
            if member.id == member_id:
                return member
        return None

    def display_members(self):
        '''Método para mostrar los miembros disponibles en la biblioteca'''
        if not self.members:
            print("\nNo hay miembros disponibles.\n")
            return
        print("\nMiembros disponibles en biblioteca:\n")
        for member in self.members:
            print(f"ID miembro: {member.id}\nNombre: {member.name}\nCantidad de libros prestados: {len(member.issued_books)}\n")
            for book_id in member.issued_books:
                book = self.find_book_by_id(book_id)
                if book:
                    print(f"  Libro ID: {book.id}\n  Titulo: {book.title}\n  Autor: {book.author}\n")
        memory_management.display_memory_usage()

    def search_member(self, member_id):
        '''Método para buscar un miembro por su ID y mostrar los libros prestados'''
        member = self.find_member_by_id(member_id)
        if member:
            print(f"ID miembro: {member.id}\nNombre: {member.name}\nCantidad de libros prestados: {len(member.issued_books)}\n")
            for book_id in member.issued_books:
                book = self.find_book_by_id(book_id)
                if book:
                    print(f"  Libro ID: {book.id}\n  Titulo: {book.title}\n  Autor: {book.author}\n")
        else:
            print("\nMiembro no encontrado.\n")
        memory_management.display_memory_usage()

    def save_library_to_file(self, filename):
        '''Método para guardar la biblioteca en un archivo JSON'''
        with open(filename, 'w', encoding='UTF-8') as file:
            json.dump([book.to_dict() for book in self.books], file, ensure_ascii=False, indent=4)
        print(f"Biblioteca guardada exitosamente en {filename}\n")
        memory_management.display_memory_usage()

    def load_library_from_file(self, filename):
        '''Método para cargar la biblioteca desde un archivo JSON'''
        try:
            with open(filename, 'r', encoding='UTF-8') as file:
                books_data = json.load(file)
                self.books = [DigitalBook.from_dict(data) if "file_format" in data else Book.from_dict(data) for data in books_data]
            print(f"Biblioteca cargada exitosamente desde {filename}\n")
        except FileNotFoundError:
            print("Error al abrir el archivo para cargar la biblioteca.\n")
        memory_management.display_memory_usage()

    def save_members_to_file(self, filename):
        '''Método para guardar los miembros en un archivo JSON'''
        with open(filename, 'w', encoding='UTF-8') as file:
            json.dump([member.to_dict() for member in self.members], file, ensure_ascii=False, indent=4)
        print(f"Miembros guardados exitosamente en {filename}\n")
        memory_management.display_memory_usage()

    def load_members_from_file(self, filename):
        '''Método para cargar los miembros desde un archivo JSON'''
        try:
            with open(filename, 'r', encoding='UTF-8') as file:
                members_data = json.load(file)
                self.members = [Member.from_dict(data) for data in members_data]
            print(f"Miembros cargados exitosamente desde {filename}\n")
        except FileNotFoundError:
            print("Error al abrir el archivo para cargar los miembros.\n")
        memory_management.display_memory_usage()
``` 
* Esta clase administra la colección de libros y miembros, y proporciona métodos para las operaciones de la biblioteca.

<br><br>
```python

def main():
    '''Función principal para ejecutar el programa'''
    library = Library()
    library.load_library_from_file("library.json")
    library.load_members_from_file("members.json")

    while True:
        print("\nMenu de sistema de manejo de biblioteca\n")
        print("\t1. Agregar un libro")
        print("\t2. Mostrar libros disponibles")
        print("\t3. Agregar un miembro")
        print("\t4. Prestar libro")
        print("\t5. Devolver libro")
        print("\t6. Mostrar miembros disponibles")
        print("\t7. Buscar miembro")
        print("\t8. Guardar y salir")
        choice = int(input("Indica tu opcion: "))

        if choice == 1:
            book_id = int(input("Ingresa ID del libro: "))
            title = input("Ingresa titulo del libro: ")
            author = input("Ingresa nombre del autor: ")
            publication_year = int(input("Ingresa el ano de publicacion: "))
            genre = input("Ingresa el genero del libro: ")
            quantity = int(input("Ingresa la cantidad de libros: "))
            is_digital = input("Es un libro digital? (s/n): ").lower() == 's'
            if is_digital:
                file_format = input("Ingresa el formato del archivo: ")
                book = DigitalBook(book_id, title, author, publication_year, genre, quantity, file_format)
            else:
                book = Book(book_id, title, author, publication_year, genre, quantity)
            library.add_book(book)
        elif choice == 2:
            library.display_books()
        elif choice == 3:
            member_id = int(input("Ingresa el ID del miembro: "))
            name = input("Ingresa el nombre del miembro: ")
            member = Member(member_id, name)
            library.add_member(member)
        elif choice == 4:
            member_id = int(input("Ingresa el ID del miembro: "))
            book_id = int(input("Ingresa el ID del libro: "))
            library.issue_book(book_id, member_id)
        elif choice == 5:
            member_id = int(input("Ingresa el ID del miembro: "))
            book_id = int(input("Ingresa el ID del libro: "))
            library.return_book(book_id, member_id)
        elif choice == 6:
            library.display_members()
        elif choice == 7:
            member_id = int(input("Ingresa el ID del miembro: "))
            library.search_member(member_id)
        elif choice == 8:
            library.save_library_to_file("library.json")
            library.save_members_to_file("members.json")
            print("Saliendo del programa\n")
            break
        else:
            print("Esta no es una opcion valida!!!\n")
``` 
* Esto define la función principal, que es el punto de entrada del programa cuando se ejecuta directamente.

<br><br>
```python
if __name__ == "__main__":
    main()
``` 
* Esta es una construcción estándar de Python. Garantiza que la main()función se llame solo cuando el script se ejecuta directamente y no cuando se importa como módulo en otro script.


<br><br><br>
**memory_management.py**  
```python
class MemoryManagement:
    '''Class to manage memory usage'''
    def __init__(self):
        self.heap_allocations = 0
        self.heap_deallocations = 0

    def increment_heap_allocations(self, size):
        '''Increment heap allocations'''
        self.heap_allocations += size

    def increment_heap_deallocations(self, size):
        '''Increment heap deallocations '''
        self.heap_deallocations += size

    def display_memory_usage(self):
        '''Display memory usage'''
        print(f"Heap allocations: {self.heap_allocations} bytes")
        print(f"Heap deallocations: {self.heap_deallocations} bytes")
``` 
* class MemoryManagement::Define una clase denominada MemoryManagementpara encapsular la funcionalidad de seguimiento de memoria.
* __init__(self)::El constructor inicializa dos variables de instancia:
    * self.heap_allocations = 0: Almacena la cantidad total de asignaciones de montón.
    * self.heap_deallocations = 0:Almacena el número total de desasignaciones de montón.
* increment_heap_allocations(self, size):Este método incrementa el self.heap_allocationscontador en el valor especificado size.
* increment_heap_deallocations(self, size):Este método incrementa el self.heap_deallocationscontador en el valor especificado size. De igual forma, sizesiempre es 1 en el código proporcionado.
* display_memory_usage(self):Este método imprime los valores actuales de self.heap_allocationsy self.heap_deallocationsen la consola, proporcionando un resumen del uso de memoria.

<br><br>
```python
memory_management = MemoryManagement()
``` 
*Esta línea crea una única instancia de la MemoryManagementclase y la asigna a la variable global memory_management. Esto permite acceder a la función de seguimiento de memoria desde otros módulos (como biblioteca.pyy biblioteca_web.py).




<br><br><br>
**FUNCIONAMIENTO DEL PROGRAMA**  

<img src="./imgs/img1.png." alt="nombx" width="150" height="auto">

El programa solicita al usuario que ingrese los detalles del libro: ID, título, autor, año de publicación, género, cantidad y si es un libro digital.

<img src="./imgs/img2.png." alt="nombx" width="150" height="auto">

El programa muestra los detalles del libro que se acaba de agregar: ID, título, autor, año de publicación, género, cantidad y formato de archivo.

<img src="./imgs/img3.png." alt="nombx" width="150" height="auto">

El programa solicita el nombre y la identificación del miembro.

<img src="./imgs/img4.png." alt="nombx" width="150" height="auto">

* El programa solicita el ID del miembro y el ID del libro.
* Se imprime el mensaje de depuración "Debug##book[...] member[...]", que muestra las ubicaciones de memoria de los objetos book y member.
* It confirms "Libro prestado satisfactoriamente!" 

<img src="./imgs/img5.png." alt="nombx" width="150" height="auto">

* El programa solicita el ID del miembro y el ID del libro.
* El usuario ingresa los ID.
* It confirms "Libro devuelto satisfactoriamente!" 

<img src="./imgs/img6.png." alt="nombx" width="150" height="auto">

El programa muestra los detalles del miembro: ID, nombre y la cantidad de libros que ha tomado prestados (que en este momento es 0). 

<img src="./imgs/img7.png." alt="nombx" width="150" height="auto">

* El programa solicita el ID del miembro.
* El usuario ingresa el ID.
* El programa muestra los datos del miembro (ID, nombre y número de libros prestados).

<img src="./imgs/img8.png." alt="nombx" width="150" height="auto">

El programa guarda los datos de la biblioteca en "library.json" y los datos de los miembros en "members.json".



<br><br><br>
**VISUALIZACION DEL SITIO WEB DE BIBLIOTECA**  
<img src="./imgs/img9.png." alt="nombx">

<img src="./imgs/img10.png." alt="nombx">

<img src="./imgs/img11.png." alt="nombx">