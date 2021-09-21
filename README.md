# Keycloak Adv Conditional OTP - CIDR

This is a proof of concept plugin for Keycloak to add support for skipping an OTP via CIDR in the conditional OTP flow. Instead of building a brand new plugin, we simply build off of the code for the `ConditionalOtpFormAuthenticator` located in the `keycloak/keycloak` repository.

## Why?

This is a common way of defining "trusted networks" within an organization for internal ranges. This can also help prevent user OTP exhaustion. While it appears to be possible to use the HTTP header options to achieve this, it requires unnecessary extra work to build an appropriate regex.

## Build / Usage

This module is compiled and packaged in a docker conatiner. To build yourself:

```bash
docker build -t keycloak-otp-cidr:15.0.2 .
```

## Improvements

Some future improvements should be expected in a true final implementation.

* Improve `IpAddressMatcher` - this is currently just code stolen from the springboot web security module, and removed any spring references for easy use. Long term, it would probably be wise to use an upstream library packaged within Keycloak.
* Add option for "Force OTP by CIDR" - this would perform the inverse functionality of what this package was designed to do. Perhaps the use case of overriding specific smaller subnets within a larger one to ensure OTP usage by specific subset of users.