# Initial Stage
FROM golang:1.22.5 as base 

WORKDIR /app

COPY go.mod .

RUN go mod download

COPY . .

RUN go build -o kunle_app .

# Final stage

FROM gcr.io/distroless/base

COPY --from=base /app/kunle_app .

COPY --from=base /app/static ./static

CMD [ "./kunle-app" ]

