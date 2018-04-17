# Copyright 2015 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM golang:1.9.5

ENV EDITOR vim
ENV SHELL zsh

RUN apt-get -q update && \
  apt-get install --no-install-recommends -y --force-yes -q \
	locales \
	ca-certificates \
	zsh \
	curl \
	git \
	vim-nox \
	tmux \
	build-essential \
	cmake \
	python-dev \
	exuberant-ctags \
	graphviz \
	&& \
  apt-get clean && \
  rm /var/lib/apt/lists/*_*

RUN go get	github.com/nsf/gocode \
		golang.org/x/tools/cmd/goimports \
		github.com/rogpeppe/godef \
		golang.org/x/tools/cmd/guru \
		golang.org/x/tools/cmd/gorename \
		github.com/golang/lint/golint \
		github.com/kisielk/errcheck \
		github.com/jstemmer/gotags \
		github.com/garyburd/go-explorer/src/getool \
		github.com/golang/dep/cmd/dep \
		github.com/reconquest/hierr-go \
		github.com/zmb3/gogetdoc \
		github.com/davidrjenni/reftools/cmd/fillstruct \
		github.com/fatih/motion \
		github.com/josharian/impl \
		github.com/fatih/gomodifytags \
		github.com/dominikh/go-tools/cmd/keyify \
		github.com/klauspost/asmfmt/cmd/asmfmt \
		github.com/alecthomas/gometalinter \
		github.com/derekparker/delve/cmd/dlv

RUN mkdir -p ~/.vim/bundle && \ 
	git clone https://github.com/fatih/vim-go.git ~/.vim/plugged/vim-go && \
	git --git-dir=/root/.vim/plugged/vim-go/.git --work-tree=/root/.vim/plugged/vim-go checkout 'v1.11' && \
	git clone https://github.com/ctrlpvim/ctrlp.vim.git ~/.vim/plugged/ctrlp.vim && \
	git clone https://github.com/majutsushi/tagbar.git ~/.vim/plugged/tagbar && \
	git clone https://github.com/Shougo/neocomplete.vim.git ~/.vim/plugged/neocomplete && \
	git clone https://github.com/garyburd/go-explorer.git ~/.vim/plugged/go-explorer && \
	git clone https://github.com/vim-airline/vim-airline.git ~/.vim/plugged/vim-airline && \
	git clone https://github.com/vim-airline/vim-airline-themes.git ~/.vim/plugged/vim-airline-themes && \
	git clone https://github.com/altercation/vim-colors-solarized.git ~/.vim/plugged/vim-colors-solarized && \
	git clone https://github.com/sjl/badwolf.git ~/.vim/plugged/badwolf && \
	git clone https://github.com/tpope/vim-git.git ~/.vim/plugged/vim-git && \
	git clone https://github.com/tpope/vim-fugitive.git ~/.vim/plugged/vim-fugitive && \
	git clone https://github.com/benmills/vimux.git ~/.vim/plugged/vimux

RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

RUN curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | /bin/zsh || true
RUN chmod 755 -R /go

ADD vimrc /root/.vimrc
ADD zshrc /root/.zshrc

ENV TERM="xterm-256color"

RUN sed -i 's/^# *\(ru_RU.UTF-8\)/\1/' /etc/locale.gen
RUN locale-gen
ENV LANG=ru_RU.UTF-8 \
	LC_CTYPE="ru_RU.UTF-8"

CMD /usr/bin/tmux new "/usr/bin/vim /go/src/${PROJECT_FILE_PATH}"
