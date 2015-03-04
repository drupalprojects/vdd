mercurial Cookbook CHANGELOG
============================
This file is used to list changes made in each version of the mercurla cookbook.


v2.0.4
------
[COOK-3794] - Properly manage "update" for mercurial


v2.0.2
------
### Bug
- **[COOK-2918](https://tickets.opscode.com/browse/COOK-2918)** - Add `build-essential` dependency

v2.0.0
------
Requires Chef 11 for `use_inline_resources` in LWRP.

### Bug
- [COOK-2346]: LWRP sends notifications to inline exec resources that cannot be found

v1.1.4
------
- [COOK-2278] - Install mercurial using pip
- [COOK-2279] - typo in README.md

v1.1.2
------
- [COOK-2033] - only set recursive permissions if mode is used in mercurial resource

v1.1.0
------
- [COOK-1945] - cleanup provider
- [COOK-1946] - windows support

v1.0.0
------
- [COOK-1373] - README example correction
- [COOK-1179] - LWRP for repo management

For further discussion about possible changes to the LWRP, see COOK-879, whereby it may become a fully fledged provider for Chef's built in scm_repo resource.

v0.7.1
------
- Current public release
