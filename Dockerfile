FROM pnnlhep/osg-compute
MAINTAINER Kevin Fox "Kevin.Fox@pnnl.gov"

ADD ./fts3.repo /etc/yum.repos.d/fts3.repo
ADD ./liberty.repo /etc/yum.repos.d/liberty.repo
RUN rpm -Uvh http://software.internet2.edu/rpms/el6/x86_64/main/RPMS/Internet2-repo-0.6-1.noarch.rpm

RUN yum install -y sysstat bwctl-client strace bzip2-devel openssl-devel ncurses-devel readline-devel screen telnet zsh gdb git osg-client osg-client-condor edg-mkgridmap lcmaps-plugins-gums-client lcmaps-plugins-basic lcmaps-plugins-verify-proxy fts-client voms-admin-client python-heatclient python-cinderclient python-novaclient python-neutronclient openssh-server ansible lsof vim-enhanced strace gdb man

#FIXME.... xltop?

ADD ./start.sh /etc/start.sh
RUN chmod +x /etc/start.sh

CMD ["/etc/start.sh"]
