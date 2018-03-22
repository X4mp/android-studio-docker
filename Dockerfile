FROM ubuntu

RUN dpkg --add-architecture i386 && \
    apt-get update && apt-get install -y --no-install-recommends sudo lib32z1 lib32ncurses5 lib32stdc++6 lib32z1 lib32ncurses5 lib32stdc++6 openjdk-8-jre openjdk-8-jdk && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV USER ubuntu
ENV UID 1000

RUN export uid=1000 gid=1000 && \
    mkdir -p /home/ubuntu && \
    echo "ubuntu:x:${uid}:${gid}:Developer,,,:/home/ubuntu:/bin/bash" >> /etc/passwd && \
    echo "ubuntu:x:${uid}:" >> /etc/group && \
    echo "ubuntu ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/ubuntu && \
    chmod 0440 /etc/sudoers.d/ubuntu && \
    chown ${uid}:${gid} -R /home/ubuntu && \
    mkdir -p /etc/udev/rules.d 

ADD 51-android.rules /etc/udev/rules.d
RUN chmod a+r /etc/udev/rules.d/51-android.rules

VOLUME /opt/android-studio
VOLUME /home/ubuntu/.android

#ADD entrypoint.sh /
#ENTRYPOINT ["/entrypoint.sh"]

#CMD ["${ANDROID_STUDIO}/bin/studio.sh"] # will not do variable substitution
CMD ["/opt/android-studio/bin/studio.sh"]
