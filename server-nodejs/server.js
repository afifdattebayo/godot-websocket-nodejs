const ws = require('ws');

const server = new ws.Server({ port: 3000 })

server.on("connection", socket => {
    socket.on("message", message => {
        let data = JSON.parse(message)
        console.log(data)
    })

    socket.on("close", (code, reason) => {
        console.log(code, reason)
    })

    socket.send(JSON.stringify({ "test": "test" }))
})