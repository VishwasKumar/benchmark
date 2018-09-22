#!/bin/bash
 
mkdir -p data/wrk
 
function run_benchmark() {
    name=$1
 
    echo Framework $name 1 thread 100 connections 3 minutes with 500 connections
    wrk2 -t1 -c100 -d3m -R500 --latency http://localhost:8080/framework > data/wrk/$name-framework-t1-c100-d3m-r500.txt
    
    echo Benchmark $name 1 thread 100 connections 3 minutes with 500 connections
    wrk2 -t1 -c100 -d3m -R500 --latency http://localhost:8080/benchmark > data/wrk/$name-benchmark-t1-c100-d3m-r500.txt
 
    echo Framework $name 1 thread 100 connections 3 minutes with 1000 connections
    wrk2 -t1 -c100 -d3m -R1000 --latency http://localhost:8080/framework > data/wrk/$name-framework-t1-c100-d3m-r1000.txt
    
    echo Benchmark $name 1 thread 100 connections 3 minutes with 1000 connections
    wrk2 -t1 -c100 -d3m -R1000 --latency http://localhost:8080/benchmark > data/wrk/$name-benchmark-t1-c100-d3m-r1000.txt
 
    echo Framework $name 4 thread 500 connections 3 minutes with 1000 connections
    wrk2 -t4 -c500 -d3m -R1000 --latency http://localhost:8080/framework > data/wrk/$name-framework-t4-c500-d3m-r1000.txt
    
    echo Benchmark $name 4 thread 500 connections 3 minutes with 1000 connections
    wrk2 -t4 -c500 -d3m -R1000 --latency http://localhost:8080/benchmark > data/wrk/$name-benchmark-t4-c500-d3m-r1000.txt
}
 
 
figlet Java Spring Boot
 
cd java-spring
 
mvn spring-boot:run &
APP_PID=$!
 
cd ..
 
sleep 10
 
run_benchmark spring-boot
 
 
kill -9 $APP_PID
 
sleep 2
 
figlet GoLang
 
golang-baseline/service &
APP_PID=$!
 
sleep 5
 
run_benchmark golang
 
kill -9 $APP_PID
 
sleep 2
 
figlet C++
 
cpp-baseline/build/cpp-baseline &
APP_PID=$!
 
sleep 5
 
run_benchmark cpp
 
kill -9 $APP_PID
 
figlet Done!