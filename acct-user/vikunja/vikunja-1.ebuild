# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="Dedicated user for vikunja"
ACCT_USER_ID=-1
ACCT_USER_GROUPS=( vikunja )

ACCT_USER_HOME=/var/lib/vikunja
ACCT_USER_HOME_PERMS=0770

acct-user_add_deps
