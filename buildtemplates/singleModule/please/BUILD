java_library(
    name = 'example',
    srcs = glob(['src/main/java/**/*.java']),
)

java_library(
    name = 'example-tests',
    srcs = glob(['src/test/java/**/*.java']),
    deps = [
        ':example',
        ':hamcrest-core',
        ':junit',
    ],
)

java_test(
    name = 'tests',
    srcs = glob(['src/test/java/**/*Test.java'], excludes = ['src/test/java/**/*AbstractTest.java']),
    resources = glob([
        'src/test/resources/**/*',
        'src/main/resources/**/*',
    ]),
    deps = [
        ':example',
        ':example-tests',
        ':hamcrest-core',
        ':junit',
    ],
)

# define a dependency
maven_jar(
    name = 'junit',
    id = 'junit:junit:4.11',
)

maven_jar(
    name = 'hamcrest-core',
    id = 'org.hamcrest:hamcrest-core:1.3',
)
