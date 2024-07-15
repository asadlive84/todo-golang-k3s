VERSION:=v0.01


build:
	@ docker compose down --remove-orphans -v && docker compose up --build -d