# Stage 1: Build the .NET application
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copy the .csproj and restore as distinct layers to optimize builds
COPY *.csproj ./
RUN dotnet restore

# Copy the entire application source code and build it
COPY . ./
RUN dotnet publish -c Release -o /app/out

# Stage 2: Create a lightweight runtime image for the app
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app

# Copy the build output from the previous stage
COPY --from=build /app/out ./

# Set the entry point to run the application
ENTRYPOINT ["dotnet", "DeployRight.dll"]
