FROM python:3.7 as build
ARG SITEURL=https://blurringexistence.net
ENV HOME=/site
ENV PATH=$PATH:/site/.local/bin
WORKDIR /site
RUN chown nobody:nogroup /site
USER nobody
ADD --chown=nobody:nogroup . .
RUN pip install --user --no-cache-dir -r requirements.txt \
	&& pelican -s publishconf.py

FROM nginx:latest
COPY --from=build /site/output /usr/share/nginx/html/
