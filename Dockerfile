# Etapa de build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copia los archivos del proyecto y restaura dependencias
COPY . ./
RUN dotnet restore

# Publica la aplicación en modo Release
RUN dotnet publish -c Release -o out

# Etapa de runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/out ./

# Expone el puerto por defecto de ASP.NET
EXPOSE 80

# Comando de inicio
ENTRYPOINT ["dotnet", "BlazorApp1.dll"]