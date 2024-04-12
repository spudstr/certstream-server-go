FROM alpine

WORKDIR /app

ENV USER=certstreamserver
ENV UID=10001

# Create user
RUN adduser \
    --disabled-password \
    --gecos "" \
    --home "/nonexistent" \
    --shell "/sbin/nologin" \
    --no-create-home \
    --uid "${UID}" \
    "${USER}"

# Copy our static executable.
COPY certstream-server-go /app/certstream-server-go
COPY ./config.yaml /app/config.yaml

RUN chmod +x /app/certstream-server-go

# Use an unprivileged user.
USER certstreamserver:certstreamserver

EXPOSE 8080

#ENTRYPOINT ["tail", "-f", "/dev/null"]
ENTRYPOINT ["/app/certstream-server-go","-config","/app/config.yaml"]