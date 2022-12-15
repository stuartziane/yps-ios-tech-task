# movieDeets (iOS)
My submission for the YPS iOS technical task

I've been working on the dev branch.  There is a test branch but I think it's a couple of commits behind dev.

There are a couple of things I'd have improved, including the refactoring of the movie detail view into subviews, to make it more readable.  Something strange was going on with VStack alignment and spacing, which I need to look into.

Paging isn't currently implemented, as the API doesn't seem to return large amounts of results, but I can implement this if it's needed.

Extensive use of AsyncImage is used, as quite a few of the image urls seem to fail.  I know how I can sort this out.

I have written tests for making sure that the API manager can build a valid url, as this is critical.  I would normally write more tests, and I've used a protocol for the API manager so that I can build a mock API manager.

I'm looking forward to your feedback.

Stuart
