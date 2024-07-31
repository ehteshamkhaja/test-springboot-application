#!/bin/bash

helmrelease="springboot-app"
cd manifests && helm install $helmrelease myspringboot-app  
