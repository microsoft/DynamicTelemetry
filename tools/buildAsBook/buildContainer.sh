#!/bin/bash

podman image save  --format oci-archive -o cdocs.mermaid.tar chgray123/chgray_repro:cdocs.mermaid
