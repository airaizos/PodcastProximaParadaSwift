# Podcast Próxima Parada Swift

Reproductor del podcast Próxima Parada Swift publicado en https://proximaparadaswift.dev

Proyecto realizado con MVVM en SwiftUI, utilizando SwiftData, Combine, AVFoundation, Regex,

## Funcionalidades
Ordena los episodios por fecha, búscalos por título o filtra por categoría
Escucha el episodio ajustando la velocidad de reproducción
Descarga el audio de los episodios para escucharlos después
Lleva el registro de tus episodios favoritos y escuchados
Obtén un listado de enlaces que recomiendo para aprender Swift


## Retos personales conseguidos
* AVFoundation para reproducir los audios del podcast y poder cambiar la velocidad de reproducción.
* Regex (Expresiones Regulares) para obtener a patir del json generado por la API de Wordpress el contenido y de ahí obtener la url del audio.
* SwiftData para la persistencia de datos 
* Convertir correctamente un post de Wordpress en formato HTML a un `AttributedString` 


## Referencias
[Date Formatter](https://nsdateformatter.com)
[Swifty Place](https://www.swiftyplace.com/blog/fetch-and-filter-in-swiftdata)
[Swift Data by Example](https://www.hackingwithswift.com/quick-start/swiftdata)
[Json Beautify](https://jsonbeautify.com)
[Chat GP3](https://chat.openai.com)
[AV Player & SwiftUI](https://chris-mash.medium.com/avplayer-swiftui-b87af6d0553)


## Por venir
* Tests
* Refactorizar a Observable
