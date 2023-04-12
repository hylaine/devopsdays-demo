# Base image
FROM mcr.microsoft.com/mssql/server:2022-latest

# Set environment variables
ENV ACCEPT_EULA=Y
ENV SA_PASSWORD=DevOpsDaysP4ssword!

# Change to root to create directory
USER root

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Copy the SQL Server scripts to the container
COPY Instantiate.sql /usr/src/app
COPY sqlserver-entrypoint.sh /usr/src/app

RUN chmod +x /usr/src/app/Instantiate.sql
RUN chmod +x /usr/src/app/sqlserver-entrypoint.sh

# set mssql as owner of the app directory
RUN chown mssql /usr/src/app

# change back to user mssql
USER mssql

# Expose SQL Server port
EXPOSE 14330

# Run SQL Server initialization script on startup
ENTRYPOINT ["/bin/bash", "/usr/src/app/sqlserver-entrypoint.sh"]
CMD ["--help"]
# CMD /opt/mssql/bin/sqlservr & ping 127.0.0.1 -n 30 > nul && /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P DevOpsDaysP4ssword -d master -i /usr/src/app/Instantiate.sql
# CMD /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P DevOpsDaysP4ssword -d master -i /usr/src/app/SeedData.sql