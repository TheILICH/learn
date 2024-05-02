FROM golang:1.22.2-alpine3.19 as builder

WORKDIR /app
COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -o myapp

FROM alpine:3.19

WORKDIR /app
COPY --from=builder /app/myapp /app/
COPY --from=builder /app/templates /app/templates

EXPOSE 80
CMD ["/app/myapp"]

