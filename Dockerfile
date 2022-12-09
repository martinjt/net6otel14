FROM mcr.microsoft.com/dotnet/sdk:7.0-alpine AS build

WORKDIR /code

COPY . .

RUN dotnet restore
RUN dotnet publish -c release -o /app

# final stage/image
FROM mcr.microsoft.com/dotnet/aspnet:6.0-alpine

WORKDIR /app
COPY --from=build /app .

ENTRYPOINT ["dotnet", "net6otel.dll"]