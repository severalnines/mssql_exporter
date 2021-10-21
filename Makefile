VERSION := "0.5.4"
# VERSION := `git describe --tags`
PACKAGE := mssql_exporter-$(VERSION).linux-amd64

package: 
	wget https://github.com/DanielOliver/mssql_exporter/archive/refs/tags/v0.5.4.tar.gz; tar xvfz v0.5.4.tar.gz &&  cd mssql_exporter-0.5.4/src/server/ && sudo  DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1 dotnet publish -c Release -r linux-x64  -o ./bin/linux_x64 -p:PublishSingleFile=true --self-contained true -p:PublishTrimmed=true && cd -
	rm -rf $(PACKAGE)
	mkdir $(PACKAGE) 
	cp -fva mssql_exporter-0.5.4/src/server/bin/linux_x64/mssql_exporter $(PACKAGE)/
	#cp -fva mssql_exporter-0.5.4/src/server/bin/linux_x64/metrics.json $(PACKAGE)/
	cp -fva metrics.json $(PACKAGE)/
	tar -czvpf $(PACKAGE).tar.gz $(PACKAGE)

clean:
	rm -f mssql_exporter-0.5.4/src/server/bin/linux_x64/mssql_exporter

.PHONY: clean
