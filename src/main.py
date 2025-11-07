from fastapi import FastAPI, Request
from fastapi.staticfiles import StaticFiles
from fastapi.templating import Jinja2Templates

app = FastAPI()
app.mount("/web/assets", StaticFiles(directory="web/assets"), name="assets")
templates = Jinja2Templates(directory="web/pages")


@app.get("/")
async def root(request: Request):
    return templates.TemplateResponse(name="base.html", request=request, context={"msg": "hello_world" })
