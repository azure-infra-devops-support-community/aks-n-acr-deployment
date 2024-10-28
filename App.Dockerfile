FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env
WORKDIR /App

# Copy everything from the current directory on the host to the /App directory in the container.
COPY . ./

# Restore dependencies for the application as distinct layers
RUN dotnet restore

# Builds and publishes the application in Release mode. The output is stored in the out folder inside the container.
RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /App
COPY --from=build-env /App/out .
ENTRYPOINT ["dotnet", "DotNet.Docker.dll"]