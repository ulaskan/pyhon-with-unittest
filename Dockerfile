FROM python:3.9.10-slim-buster

ARG USERNAME

RUN apt-get update && apt-get upgrade
RUN useradd -m ${USERNAME}

COPY bashrc /home/${USERNAME}/.bashrc
RUN mkdir -p /app
COPY Pipfile /app
COPY Pipfile.lock /app
RUN chown -R ${USERNAME}:${USERNAME} /app
WORKDIR /app

USER ${USERNAME}
ENV PATH "$PATH:/home/${USERNAME}/.local/bin"
RUN python -m pip install --upgrade pip
RUN pip install pipenv
RUN pipenv install

CMD ["sleep", "36000"]
