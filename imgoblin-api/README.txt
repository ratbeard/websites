Create the db container:

		docker run -name imgoblin-db ratbeard/imgoblin-db true

Run this container:

		docker run -d -p 7777:7777 --volumes-from=imgoblin-db1 ratbeard/imgoblin-api


