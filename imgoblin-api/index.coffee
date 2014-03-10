express = require 'express'
cors = require 'cors'
fs = require 'fs'
path = require 'path'
Datastore = require('nedb')

#
# Server
#
PORT = 7777
DB_FILE = "/data/imgoblin/db.json"
UPLOADS_DIR = "/data/imgoblin/uploads"
IMAGES_DIR = "/data/imgoblin/images"

app = express()
app.use(express.logger('dev'))
#app.use(cors())
app.use(express.bodyParser(keepExtensions: true, uploadDir: UPLOADS_DIR))
app.use(express.static(IMAGES_DIR))
console.log("Listening on port #{PORT}")
app.listen(PORT)

sendError = (response, message) ->
	response.statusCode = 400
	response.send(JSON.stringify(error: message))

send = (response, result) ->
	response.send(JSON.stringify(result, "", "\t"))

# GET / 
# Returns all images as json: `{results: []}`
app.get '/', (request, response) ->
	#if request.accepts('json')
	imageDb.find {}, (error, images) ->
		return sendError(response, error) if error
		send(response, results: images)

# POST {}
# Uploads a new image
# Returns the new image as json
app.post '/', (request, response) ->
	upload = request.files?.image
	if !upload
		return sendError(response, "no upload")

	name = request.body.name ? (+new Date()).toString(36)
	name = path.basename(name)

	tmpPath = upload.path
	nameWithExtension = path.basename(name) + path.extname(tmpPath)
	newPath = path.join(IMAGES_DIR, nameWithExtension)
	console.log 'rename', tmpPath, "=>", newPath
	fs.rename(tmpPath, newPath, (error) ->
		return sendError(response, error) if error
		url = "http://#{request.headers.host}/#{nameWithExtension}"
		image = { name, url }
		imageDb.insert(image, (error, image) ->
			return sendError(response, error) if error
			send(response, image)
		)
	)

	

#
# DB
#
imageDb = new Datastore(
	filename: DB_FILE
	autoload: true
)

