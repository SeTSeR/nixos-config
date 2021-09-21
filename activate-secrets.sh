#!/bin/sh

export PR_SECRET=$(bw get notes "proxy secret 1")
export AN_SECRET=$(bw get notes "proxy secret 2")
export STUD_NUMBER=$(bw get notes "stud number")
export STUD_MAIL_PASSWORD=$(bw get notes "stud mail password")
export GMAIL_MBSYNC_PASSWORD=$(bw get notes "gmail mbsync password")
export YANDEX_MAIL_PASSWORD=$(bw get notes "yandex mail password")
export ORG_GCAL_CLIENT_ID=$(bw get notes "org gcal client id")
export ORG_GCAL_CLIENT_SECRET=$(bw get notes "org gcal client secret")

envsubst -i secret.nix -o secret-subst.nix
mv secret-subst.nix secret.nix
