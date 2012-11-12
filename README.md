= JBoss Tools Facade repository =

This repository is only a "Facade" repository which links you to all JBoss Tools repositories via submodules.

== Usage ==

If you're a contributor who wants to write code, DON'T USE IT. Use direct jbosstools-* repositories instead.
This repository can be used by CI servers to get all sources in one shot, and to build everything in one shot:

=== Get all sources ===

Get all master:
<pre>
git clone git://github.com/mickaelistria/jbosstools-all.git
./submodules.sh init master
<pre>

Get all branches "jbosstools-4.0.0.Alpha2":
<pre>
git clone git://github.com/mickaelistria/jbosstools-all.git
./submodules.sh init jbosstools-4.0.0.Alpha2
</pre>

=== Build everything ===

First install parent and Target-platform, if you don't want to rely on JBoss Nexus instance.
<pre>
cd <repo>/jbosstools-build/target-platforms
mvn install
cd <repo>/jbosstools-build/parent
mvn install
<pre>

Then:
<pre>
mvn install -Dno.jbosstools.site
</pre>
